using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Windows.Forms;
using OpenDentBusiness;
using NHunspell;
using System.Text.RegularExpressions;
using OpenDental.UI;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Text;
using System.Linq;
using CodeBase;

namespace OpenDental {
	/// <summary>This is used instead of a regular textbox when quickpaste functionality is needed.</summary>
	public class ODtextBox:RichTextBox {//System.ComponentModel.Component

		#region IMM (Input Method Manager) dll import for IME mid composition bug (Korea and east Asian languages)

		//See post by Jon Burchel - Microsoft: https://goo.gl/d1ehJb  (an MSDN forum post shortened using google url shortener)

		[DllImport("imm32.dll",CharSet = CharSet.Unicode)]
		public static extern IntPtr ImmReleaseContext(IntPtr hWnd,IntPtr context);

		[DllImport("imm32.dll",CharSet = CharSet.Unicode)]
		private static extern int ImmGetCompositionString(IntPtr hIMC,uint dwIndex,byte[] lpBuf,int dwBufLen);

		[DllImport("imm32.dll",CharSet = CharSet.Unicode)]
		private static extern IntPtr ImmGetContext(IntPtr hWnd);

		#endregion

		private System.Windows.Forms.ContextMenu contextMenu;
		private IContainer components;// Required designer variable.
		private static Hunspell HunspellGlobal;//We create this object one time for every instance of this textbox control within the entire program.
		private QuickPasteType quickPasteType;
		private Graphics BufferGraphics;
		public Timer timerSpellCheck;
		private Point PositionOfClick;
		public MatchOD ReplWord;
		private bool _spellCheckIsEnabled;//set to true in constructor
		private bool _editMode;//set to false in constructor
		private Point textEndPoint;
		///<summary>Only used when ImeCompositionCompatibility is enabled.  Set to true when the user presses the space bar.
		///This will cause the cursor to move to the next position and no longer have composition affect the current character.
		///E.g. the Korean symbol '역' (dur) will display.  However, typing '여' (du) and then space will cause that char to no longer be affected.
		///This will allow the char 'ㄱ' (r) to appear after '여' instead of '역'.</summary>
		private bool _skipImeComposition=false;
		///<summary>Only used when ImeCompositionCompatibility is enabled.  Set to true when the user is in the middle of composing a symbol.
		///This will cause the cursor to stay over the current character and not move on (or separate) the current symbol being constructed.
		///E.g. the Korean symbol '역' (dur) will not display correctly without this set to true.  
		///When false, it will be broken apart into each character that comprizes it: 'ㅇ ㅕ ㄱ ' (d u r)</summary>
		private bool _imeComposing=false;
		///<summary>Always contains the text that should be displayed in the rich text box.  
		///Also used to store the UNICODE representation of the RichTextBox.Text property (which we override) due to a Korean bug.</summary>
		private string _msgText="";
		///<summary>Pointer to the Rich Edit version 4.1 dll.  Null unless the property () is set to true and the new version is loaded.
		///The new dll is named Msftedit.dll and the ClassName is changed from RichEdit20W to RichEdit50W.
		///The new dll has been available since Windows XP SP1, released in 2002.  .NET is just set to use the old dll by default.</summary>
		private static IntPtr _libPtr;
		private bool isImeComposition;
		private bool _detectLinksEnabled;
		///<summary>Must track menuitems that we have added, so that we know which ones to take away when reconstructing context menu.</summary>
		private List<MenuItem> _listMenuItemLinks;
		///<summary>Stores the current words for all odtextboxes and if they are spelled correctly.  Speeds up spell checking.
		///Words cannot be removed from the spelling dictionary and thus also cannot be removed from this dictionary.
		///Is a concurrent dictionary so multiple odtextboxes can add words at the same time safely.</summary>
		private static ConcurrentDictionary<string,SpellingType> _dictAllWords=new ConcurrentDictionary<string,SpellingType>();

		[Category("Behavior"), Description("Set true to enable context menu to detect links.")]
		[DefaultValue(true)]
		public bool DetectLinksEnabled {
			get {
				return _detectLinksEnabled;
			}
			set {
				_detectLinksEnabled=value;
			}
		}

		///<summary>Set true to enable spell checking in this control.</summary>
		[Category("Behavior"),Description("Set true to enable spell checking.")]
		[DefaultValue(true)]
		public bool SpellCheckIsEnabled {
			get {
				return _spellCheckIsEnabled;
			}
			set {
				_spellCheckIsEnabled=value;
			}
		}

		///<summary>Set true to enable formatted text to paste in this control.</summary>
		[Category("Behavior"),Description("Set true to allow edit mode formatting")]
		[DefaultValue(false)]
		public bool EditMode {
			get {
				return _editMode;
			}
			set {
				_editMode=value;
			}
		}

		///<summary>Set true to enable the newer version 4.1 RichEdit library.</summary>
		[Category("Behavior"), Description("Set true to enable RichEdit version 4.1 enhanced features.")]
		[DefaultValue(false)]
		public bool RichEdit4IsEnabled { get; set; }

		[DllImport("kernel32.dll",EntryPoint="LoadLibrary",CharSet=CharSet.Auto,SetLastError=true)]
		private static extern IntPtr LoadLibrary(string fileName);

		///<summary>By default .NET uses the old library, riched20.dll, which corresponds to Rich Edit versions 2.0 and 3.0.
		///As of Windows XP SP1 (2002 release date), the newer library, msftedit.dll, is included which corresponds to Rich Edit version 4.1.
		///This method attempts to load the newer library, with the enhanced features, and sets the ClassName accordingly.
		///If msftedit.dll is not found, the original default library is used.
		///The msftedit.dll library is only loaded if the libPtr==IntPtr.Zero to prevent memory leaks.</summary>
		protected override CreateParams CreateParams {
			get {
				CreateParams cParams=base.CreateParams;
				if(!RichEdit4IsEnabled) {
					return cParams;
				}
				try {
					if(_libPtr==IntPtr.Zero) {//only try to load the library if not loaded already.
						_libPtr=LoadLibrary("msftedit.dll");
					}
					if(_libPtr==IntPtr.Zero) {//still zero, library was not loaded successfully
						return cParams;
					}
					cParams.ClassName="RichEdit50W";//old ClassName: "RichEdit20W" new ClassName: "RichEdit50W"
				}
				catch(Exception) {
					//msftedit.dll must not exist, or LoadLibrary wasn't loaded, so simply return the base.CreateParams unaltered
				}
				return cParams;
			}
		}

		/*public ODtextBox(System.ComponentModel.IContainer container)
		{
			///
			/// Required for Windows.Forms Class Composition Designer support
			///
			container.Add(this);
			InitializeComponent();

		}*/

		///<summary></summary>
		public ODtextBox() {
			//We have to try catch this just in case an ODTextBox is shown before upgrading to a version that already has this preference.
			try {
				if(System.ComponentModel.LicenseManager.UsageMode == System.ComponentModel.LicenseUsageMode.Designtime
					|| this.DesignMode || !Db.HasDatabaseConnection) 
				{
					isImeComposition=false;
				}
				else {
					isImeComposition=PrefC.GetBool(PrefName.ImeCompositionCompatibility);
				}
			}
			catch(Exception ex) {
				ex.DoNothing();//Do nothing.  Just treat the ODTextBox like it always has (no composition support).
			}
			InitializeComponent();// Required for Windows.Forms Class Composition Designer support
			_spellCheckIsEnabled=true;
			this.AcceptsTab=true;//Causes CR to not also trigger OK button on a form when that button is set as AcceptButton on the form.
			this.DetectUrls=false;
			if(System.ComponentModel.LicenseManager.UsageMode!=System.ComponentModel.LicenseUsageMode.Designtime
				&& HunspellGlobal==null) {
#if DEBUG
				try {
					HunspellGlobal=new Hunspell(Properties.Resources.en_US_aff,Properties.Resources.en_US_dic);
				}
				catch(Exception ex) {
					ex.DoNothing();
					System.IO.File.Copy(@"..\..\..\Required dlls\Hunspellx64.dll","Hunspellx64.dll");
					System.IO.File.Copy(@"..\..\..\Required dlls\Hunspellx86.dll","Hunspellx86.dll");
					HunspellGlobal=new Hunspell(Properties.Resources.en_US_aff,Properties.Resources.en_US_dic);
				}
#else
				HunspellGlobal=new Hunspell(Properties.Resources.en_US_aff,Properties.Resources.en_US_dic);
#endif
			}
			EventHandler onClick=new EventHandler(menuItem_Click);
			contextMenu.MenuItems.Add("",onClick);//These five menu items will hold the suggested spelling for misspelled words.  If no misspelled words, they will not be visible.
			contextMenu.MenuItems.Add("",onClick);
			contextMenu.MenuItems.Add("",onClick);
			contextMenu.MenuItems.Add("",onClick);
			contextMenu.MenuItems.Add("",onClick);
			contextMenu.MenuItems.Add("-");
			contextMenu.MenuItems.Add(Lan.g(this,"Add to Dictionary"),onClick);
			contextMenu.MenuItems.Add(Lan.g(this,"Disable Spell Check"),onClick);
			contextMenu.MenuItems.Add("-");
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Insert Date"),onClick,Shortcut.CtrlD));
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Insert Quick Note"),onClick,Shortcut.CtrlQ));
			contextMenu.MenuItems.Add("-");
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Cut"),onClick,Shortcut.CtrlX));
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Copy"),onClick,Shortcut.CtrlC));
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Paste"),onClick,Shortcut.CtrlV));
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Paste Plain Text"),onClick));
			contextMenu.MenuItems.Add(new MenuItem(Lan.g(this,"Edit AutoNote"),onClick));
			base.BackColor=SystemColors.Window;//Needed for OnReadOnlyChanged() to change backcolor when ReadOnly because of an issue with RichTextBox.
		}

		///<summary>Clean up any resources being used.</summary>
		protected override void Dispose(bool disposing) {
			if(disposing) {
				if(components != null) {
					components.Dispose();
				}
				if(BufferGraphics!=null) {//Dispose before bitmap.
					BufferGraphics.Dispose();
					BufferGraphics=null;
				}
				//We do not dispose the hunspell object because it will be automatially disposed of when the program closes.
			}
			base.Dispose(disposing);
		}


		#region Component Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
			this.components = new System.ComponentModel.Container();
			this.contextMenu = new System.Windows.Forms.ContextMenu();
			this.timerSpellCheck = new System.Windows.Forms.Timer(this.components);
			this.SuspendLayout();
			// 
			// contextMenu
			// 
			this.contextMenu.Popup += new System.EventHandler(this.contextMenu_Popup);
			// 
			// timerSpellCheck
			// 
			this.timerSpellCheck.Interval = 500;
			this.timerSpellCheck.Tick += new System.EventHandler(this.timerSpellCheck_Tick);
			// 
			// ODtextBox
			// 
			this.ContextMenu = this.contextMenu;
			this.ScrollBars = System.Windows.Forms.RichTextBoxScrollBars.Vertical;
			this.ContentsResized += new System.Windows.Forms.ContentsResizedEventHandler(this.ODtextBox_ContentsResized);
			this.VScroll += new System.EventHandler(this.ODtextBox_VScroll);
			this.ResumeLayout(false);

		}
		#endregion

		///<summary>Statuses sent to an application when IME is doing 'composition' for a symbol.
		///See post by Jon Burchel - Microsoft: https://goo.gl/d1ehJb  (an MSDN forum post shortened using google url shortener)</summary>
		private enum WM_IME {
			GCS_RESULTSTR=0x800,
			EM_STREAMOUT=0x044A,
			WM_IME_COMPOSITION=0x10F,
			WM_IME_ENDCOMPOSITION=0x10E,
			WM_IME_STARTCOMPOSITION=0x10D
		}

		protected override void WndProc(ref Message m) {
			//The following code fixes a bug deep down in RichTextBox for foreign users that have a language that needs to use composition symbols.
			//See post by Jon Burchel - Microsoft: https://goo.gl/d1ehJb  (an MSDN forum post shortened using google url shortener)
			if(isImeComposition) {
				switch(m.Msg) {
					case (int)WM_IME.EM_STREAMOUT:
						if(_imeComposing) {
							_skipImeComposition=true;
						}
						base.WndProc(ref m);
						break;
					case (int)WM_IME.WM_IME_COMPOSITION:
						if(m.LParam.ToInt32()==(int)WM_IME.GCS_RESULTSTR) {
							IntPtr hImm=ImmGetContext(this.Handle);
							int dwSize=ImmGetCompositionString(hImm,(int)WM_IME.GCS_RESULTSTR,null,0);
							byte[] outstr=new byte[dwSize];
							ImmGetCompositionString(hImm,(int)WM_IME.GCS_RESULTSTR,outstr,dwSize);
							_msgText+=Encoding.Unicode.GetString(outstr).ToString();
							ImmReleaseContext(this.Handle,hImm);
						}
						if(_skipImeComposition) {
							_skipImeComposition=false;
							break;
						}
						base.WndProc(ref m);
						break;
					case (int)WM_IME.WM_IME_STARTCOMPOSITION:
						_imeComposing=true;
						base.WndProc(ref m);
						break;
					case (int)WM_IME.WM_IME_ENDCOMPOSITION:
						_imeComposing=false;
						base.WndProc(ref m);
						break;
					default:
						base.WndProc(ref m);
						break;
				}
			}
			else {//End IME check.
				base.WndProc(ref m);
			}
		}


		protected override void OnReadOnlyChanged(EventArgs e) {
			base.OnReadOnlyChanged(e);
			//Richtextbox does not redraw the textbox with grey after turning it ReadOnly, so we do this to immitate how textbox works.
			if(ReadOnly){
				base.BackColor=SystemColors.Control;
			}
			else{
				base.BackColor=SystemColors.Window;
			}
		}

		public override string Text {
			get {
				if(!_imeComposing) {
					_msgText=base.Text;
					return base.Text;
				}
				else {
					return _msgText;
				}
			}
			set {
				_msgText=value;
				base.Text=value;
			}
		}

		///<summary></summary>
		[Category("Behavior"),Description("This will determine which category of Quick Paste notes opens first.")]
		public QuickPasteType QuickPasteType {
			get {
				return quickPasteType;
			}
			set {
				quickPasteType=value;
				if(value==QuickPasteType.None) {
					throw new InvalidEnumArgumentException("A value for the QuickPasteType property must be set.");
				}
			}
		}

		private void contextMenu_Popup(object sender,System.EventArgs e) {
			if(SelectionLength==0) {
				contextMenu.MenuItems[12].Enabled=false;//cut
				contextMenu.MenuItems[13].Enabled=false;//copy
			}
			else {
				contextMenu.MenuItems[12].Enabled=true;
				contextMenu.MenuItems[13].Enabled=true;
			}
			if(!this._spellCheckIsEnabled
			  || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)
			  || !IsOnMisspelled(PositionOfClick)) {//did not click on a misspelled word OR spell check is disabled
				contextMenu.MenuItems[0].Visible=false;//suggestion 1
				contextMenu.MenuItems[1].Visible=false;//suggestion 2
				contextMenu.MenuItems[2].Visible=false;//suggestion 3
				contextMenu.MenuItems[3].Visible=false;//suggestion 4
				contextMenu.MenuItems[4].Visible=false;//suggestion 5
				contextMenu.MenuItems[5].Visible=false;//contextMenu separator
				contextMenu.MenuItems[6].Visible=false;//Add to Dictionary
				contextMenu.MenuItems[7].Visible=false;//Disable Spell Check
				contextMenu.MenuItems[8].Visible=false;//separator
			}
			else if(this._spellCheckIsEnabled
			  && PrefC.GetBool(PrefName.SpellCheckIsEnabled)
			  && IsOnMisspelled(PositionOfClick)) {//clicked on or near a misspelled word AND spell check is enabled
				List<string> suggestions=SpellSuggest();
				if(suggestions.Count==0) {//no suggestions
					contextMenu.MenuItems[0].Text=Lan.g(this,"No Spelling Suggestions");
					contextMenu.MenuItems[0].Visible=true;
					contextMenu.MenuItems[0].Enabled=false;//suggestion 1 set to "No Spelling Suggestions"
					contextMenu.MenuItems[1].Visible=false;//suggestion 2
					contextMenu.MenuItems[2].Visible=false;//suggestion 3
					contextMenu.MenuItems[3].Visible=false;//suggestion 4
					contextMenu.MenuItems[4].Visible=false;//suggestion 5
				}
				else {//must be on misspelled word and spell check is enabled globally and locally
					for(int i=0;i<5;i++) {//Only display first 5 suggestions if available
						if(i>=suggestions.Count) {
							contextMenu.MenuItems[i].Visible=false;
							continue;
						}
						contextMenu.MenuItems[i].Text=suggestions[i];
						contextMenu.MenuItems[i].Visible=true;
						contextMenu.MenuItems[i].Enabled=true;
					}
				}
				contextMenu.MenuItems[5].Visible=true;//contextMenu separator, will display whether or not there is a suggestion for the misspelled word
				contextMenu.MenuItems[6].Visible=true;//Add to Dictionary
				contextMenu.MenuItems[7].Visible=true;//Disable Spell Check
				contextMenu.MenuItems[8].Visible=true;//contextMenu separator
			}
			if(EditMode) {
				contextMenu.MenuItems[15].Visible=true;//Paste Plain Text
				contextMenu.MenuItems[15].Enabled=true;
			}
			else {
				contextMenu.MenuItems[15].Visible=false;//Paste Plain Text
				contextMenu.MenuItems[15].Enabled=false;
			}
			string textCur=(SelectedText!=""?SelectedText:Text);
			if(Regex.IsMatch(textCur,@"\[Prompt:""[a-zA-Z_0-9 ]+""\]")) {
				contextMenu.MenuItems[16].Visible=true;
				contextMenu.MenuItems[16].Enabled=true;
			}
			else {
				contextMenu.MenuItems[16].Visible=false;
				contextMenu.MenuItems[16].Enabled=false;
			}
			if(!PrefC.GetBool(PrefName.WikiDetectLinks)) {//NOTE: if this preference is changed while the program is open there MAY be some lingering wiki links in the context menu. 
				//It is not worth it to force users to log off and back on again, or to run the link removal code below EVERY time, even if the pref is disabled.
				return;
			}
			if(_listMenuItemLinks==null) {
				_listMenuItemLinks=new List<MenuItem>();
			}
			_listMenuItemLinks.ForEach(x => contextMenu.MenuItems.Remove(x));//remove items from previous pass.
			_listMenuItemLinks.Clear();
			_listMenuItemLinks.Add(new MenuItem("-"));
			MatchCollection matches=Regex.Matches(Text,@"\[\[.+?]]");//wiki links.
			foreach(Match match in matches) {
				_listMenuItemLinks.Add(new MenuItem("Wiki - "+match.Value.Trim('[').Trim(']'),(s,eArg) => { OpenWikiPage(match.Value.Trim('[').Trim(']')); }));
			}
			_listMenuItemLinks=_listMenuItemLinks.OrderByDescending(x=>x.Text=="-").ThenBy(x => x.Text).ToList();//alphabetize the link items.
			if(_listMenuItemLinks.Any(x => x.Text!="-")) {//at least one REAL menu item that is not the divider.
				_listMenuItemLinks.ForEach(x => contextMenu.MenuItems.Add(x));
			}
		}

		private static void OpenWikiPage(string pageTitle) {
			FormOpenDental.S_WikiLoadPage(pageTitle);
			//WikiPages.NavPageDelegate(pageTitle); //this also works, but makes an extra hop to the business layer
		}

		///<summary>Determines whether the right click was on a misspelled word.  Also sets the start and end index of chars to be replaced in text.</summary>
		private bool IsOnMisspelled(Point PositionOfClick) {
			int charIndex=this.GetCharIndexFromPosition(PositionOfClick);
			Point charLocation=this.GetPositionFromCharIndex(charIndex);
			if(PositionOfClick.Y<charLocation.Y-2 || PositionOfClick.Y>charLocation.Y+this.FontHeight+2) {//this is the closest char but they were not very close when they right clicked
				return false;
			}
			char c=this.GetCharFromPosition(PositionOfClick);
			if(c=='\n') {//if closest char is a new line char, then assume not on a misspelled word
				return false;
			}
			List<MatchOD> words=GetWords(Text);
			words=words.Where(x => x.StartIndex<=charIndex && x.StartIndex+x.Value.Length-1>=charIndex).ToList();
			if(words.Count==0) {
				return false;
			}
			ReplWord=words.FirstOrDefault();
			if(ReplWord==null) {
				return false;
			}
			SpellingType spellType;
			if(_dictAllWords.TryGetValue(ReplWord.Value,out spellType) && spellType==SpellingType.Incorrect) {
				return true;
			}
			return false;
		}

		private List<string> SpellSuggest() {
			List<string> suggestions=HunspellGlobal.Suggest(ReplWord.Value);
			return suggestions;
		}

		protected override void OnMouseDown(MouseEventArgs e) {
			if(!this.Focused) {
				this.Focus();
			}
			base.OnMouseDown(e);
			PositionOfClick=new Point(e.X,e.Y);
		}

		private void menuItem_Click(object sender,System.EventArgs e) {
			if(ReadOnly && contextMenu.MenuItems.IndexOf((MenuItem)sender)!=13) {
				MsgBox.Show(this,"This feature is currently disabled due to this text box being read only.");
				return;
			}
			switch(contextMenu.MenuItems.IndexOf((MenuItem)sender)) {
				case 0:
				case 1:
				case 2:
				case 3:
				case 4:
					if(!this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, break.  Should never happen since the suggested words won't show if spell check disabled
						break;
					}
					int originalCaret=this.SelectionStart;
					this.SelectionStart=ReplWord.StartIndex;
					this.SelectionLength=ReplWord.Value.Length;
					this.SelectedText=((MenuItem)sender).Text;
					if(this.Text.Length<=originalCaret) {
						this.SelectionStart=this.Text.Length;
					}
					else {
						this.SelectionStart=originalCaret;
					}
					timerSpellCheck.Start();
					break;
				//case 5 is separator
				case 6://Add to dict
					if(!this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, break.  Should never happen since Add to Dict won't show if spell check disabled
						break;
					}
					string newWord=ReplWord.Value;
					//guaranteed to not already exist in custom dictionary, or it wouldn't be underlined.
					DictCustom word=new DictCustom();
					word.WordText=newWord;
					DictCustoms.Insert(word);
					DataValid.SetInvalid(InvalidType.DictCustoms);
					//When we add a word to the custom dictionary, it is now correct.  We need to update our storage dict for spellcheck.
					_dictAllWords[newWord.ToLower()]=SpellingType.Custom;
					timerSpellCheck.Start();
					break;
				case 7://Disable spell check
					if(!MsgBox.Show(this,MsgBoxButtons.OKCancel,"This will disable spell checking.  To re-enable, go to Setup | Spell Check and check the \"Spell Check Enabled\" box.")) {
						break;
					}
					Prefs.UpdateBool(PrefName.SpellCheckIsEnabled,false);
					DataValid.SetInvalid(InvalidType.Prefs);
					ClearWavyLines();
					break;
				//case 8 is separator
				case 9:
					InsertDate();
					break;
				case 10://Insert Quick Note
					ShowFullDialog();
					break;
				//case 11 is separator
				case 12://cut
					base.Cut();
					break;
				case 13://copy
					base.Copy();
					break;
				case 14://paste
					if(EditMode) {
						PasteText();
					}
					else {
						PastePlainText();
					}
					break;
				case 15://paste plain text
					PastePlainText();
					break;
				case 16://Edit AutoNote
					EditAutoNote();
					break;
			}
		}

		///<summary>Pastes the content of the clipboard including the formatting.</summary>
		private void PasteText() {
			base.Paste();
		}

		///<summary>Pastes the content of the clipboard excluding the formatting.</summary>
		private void PastePlainText() {
			SelectionFont=Font;
			SelectionColor=ForeColor;
			SelectionBackColor=Color.Transparent;
			SelectionBullet=false;
			base.Paste(DataFormats.GetFormat("Text"));
		}

		///<summary></summary>
		private void EditAutoNote() {
			FormAutoNoteCompose FormA=new FormAutoNoteCompose();
			FormA.MainTextNote=SelectedText!=""?SelectedText:Text;
			FormA.ShowDialog();
			if(FormA.DialogResult==DialogResult.OK) {
				if(SelectedText!=""){
					SelectedText=FormA.CompletedNote;
				}
				else {
					Text=FormA.CompletedNote;
					SelectionStart=Text.Length;
				}
			}
		}

		private void timerSpellCheck_Tick(object sender,EventArgs e) {
			if(!this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, return
				return;
			}
			timerSpellCheck.Stop();
			SpellCheck();
		}

		private void ODtextBox_VScroll(object sender,EventArgs e) {
			if(!this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, return
				return;
			}
			timerSpellCheck.Stop();
			timerSpellCheck.Start();
		}

		protected override void OnKeyDown(KeyEventArgs e) {
			base.OnKeyDown(e);
			if(!this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, return
				return;
			}
			//The lines were shifted due to new input. This causes the location of the red wavy underline to shift down as well, so clear them.
			if(e.KeyCode==Keys.Enter) {
				ClearWavyLines();
			}
		}

		///<summary>When the contents of the text box is resized, e.g. when word wrap creates a new line, clear red wavy lines so they don't shift down.</summary>
		private void ODtextBox_ContentsResized(object sender,ContentsResizedEventArgs e) {
			try {
				if(DesignMode || !this._spellCheckIsEnabled || !PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//if spell check disabled, return
					return;
				}
			}
			catch {
				//This can only happen if designing and DesignMode is false for some reason.  Has happened when this control is two levels deep.
				//The exception happens in PrefC.GetBool() because there is no database connection in design time.
				return;
			}
			Point textEndPointCur=this.GetPositionFromCharIndex(Text.Length-1);
			if(textEndPoint==new Point(0,0)) {
				textEndPoint=textEndPointCur;
				return;
			}
			if(textEndPointCur.Y!=textEndPoint.Y) {//textEndPoint cannot be null, if not set it defaults to 0,0
				ClearWavyLines(e.NewRectangle.Width);
			}
			textEndPoint=textEndPointCur;
		}

		///<summary></summary>
		protected override void OnKeyUp(KeyEventArgs e) {
			base.OnKeyUp(e);
			if(this._spellCheckIsEnabled && PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//Only spell check if enabled
				timerSpellCheck.Stop();
			}
			int originalLength=Text.Length;
			int originalCaret=base.SelectionStart;
			string newText=QuickPasteNotes.Substitute(Text,quickPasteType);
			if(Text!=newText) {
				Text=newText;
				SelectionStart=originalCaret+Text.Length-originalLength;
			}
			//then CtrlQ
			if(e.KeyCode==Keys.Q && e.Modifiers==Keys.Control) {
				ShowFullDialog();
			}
			if(this._spellCheckIsEnabled && PrefC.GetBool(PrefName.SpellCheckIsEnabled)) {//Only spell check if enabled
				timerSpellCheck.Start();
			}
		}

		#region SpellCheck
		///<summary>The widthOverride parameter should only be explicitly set if the control is in 
		///the middle of resizing. this.Size is stale when calculating line heights in the middle of a content resize event.
		///Returns the list of line heights.  If listVisWords is not null, then will be filled with the list of visible words.</summary>
		public List<int> ClearWavyLines(int widthOverride=-1,List<MatchOD> listVisWords=null) {
			if(this.Width <= 0 || this.Height <= 0) {//Width or Height can be 0 if the window or textbox is resized.  Causes a UE when creating a Bitmap. 
				return new List<int>();//No lines.
			}
			//First we create the graphics objects we'll draw on.
			Bitmap bitmapOverlay=new Bitmap(this.Width,this.Height);
			//If it is not null, we dispose before we assign another image.
			BufferGraphics?.Dispose();
			BufferGraphics=Graphics.FromImage(bitmapOverlay);
			BufferGraphics.Clear(Color.Transparent);//We don't want to overwrite the text in the rich text box.
			Graphics graphicsTextBox=Graphics.FromHwnd(this.Handle);
			//Now we start checking where we need to clear lines
			if(Text.Length==0) {//all text was deleted, clear the entire text box
				Rectangle wavyLineArea = new Rectangle(1,1,this.Width,this.Height);
				BufferGraphics.FillRectangle(new SolidBrush(this.BackColor),wavyLineArea);
				graphicsTextBox.DrawImageUnscaled(bitmapOverlay,0,0);
				graphicsTextBox.Dispose();
				bitmapOverlay.Dispose();
				return new List<int>();//No lines.
			}
			List<int> listLineHeights=GetLineHeights(widthOverride);//Used for measuring line heights
			bool[] arrayClearedLines=new bool[listLineHeights.Count];//This clears all values to false initially.
			List <MatchOD> listWords=GetVisibleWords(listLineHeights);
			foreach(MatchOD word in listWords) {	//ListVisWords is sorted by index, so we start from the start of the visible text and go to the end
				if(_dictAllWords.ContainsKey(word.Value) && _dictAllWords[word.Value]!=SpellingType.Incorrect) {
					//We don't need to undo the underline when words that are correct.
					continue;
				}
				//Get the start and end indices for the word so we can calculate the lines it is present on.
				int startLineIndex=GetLineFromCharIndex(word.StartIndex);
				int endIndex=word.StartIndex+word.Value.Length;
				int endLineIndex=GetLineFromCharIndex(endIndex);
				//If the entire word is on one line and we've already cleared that line, then the skip to the next line.
				if(startLineIndex==endLineIndex && arrayClearedLines[startLineIndex]) {
					continue;
				}
				Point start=this.GetPositionFromCharIndex(word.StartIndex);//get pos of character at index of match
				//word may span more than one line, so white out all lines between the starting char line and the ending char line
				for(int j=startLineIndex;j<=endLineIndex;j++) {
					if(j<0 || j>=listLineHeights.Count) {
						break;//just in case, so we don't get an index out of range exception (happened once in the account module, see task #1499807)
					}
					start.Y+=listLineHeights[j];
					if(start.Y>=Height) {//y pos of the bottom of the line is below the visible area, with scroll bar active.
						break;
					}
					Rectangle wavyLineArea=new Rectangle(1,start.Y,Width,2);
					BufferGraphics.FillRectangle(new SolidBrush(BackColor),wavyLineArea);
				}
				arrayClearedLines[startLineIndex]=true;
			}
			graphicsTextBox.DrawImageUnscaled(bitmapOverlay,0,0);
			graphicsTextBox.Dispose();
			bitmapOverlay.Dispose();
			if(listVisWords!=null) {
				listVisWords.Clear();
				listVisWords.AddRange(listWords);
			}
			return listLineHeights;
		}

		///<summary>Performs spell checking against indiviudal words against the Hunspell dictionary and the custom internal dictionary.</summary>
		public void SpellCheck() {
			//Only spell check if enabled
			if(!this._spellCheckIsEnabled 
				|| !PrefC.GetBool(PrefName.SpellCheckIsEnabled)
				|| PrefC.GetBool(PrefName.ImeCompositionCompatibility))
			{
				//Do not spell check languages that use composition.  If needed in the future, fix the bug where the first char disapears in the box.
				//E.g. go into an ODTextBox, set language input to Korean, and simply type the letter 'ㅇ' (d) and wait.  It will disapear.
				return;
			}
			if(this.Width <= 0 || this.Height <= 0) {//Width or Height can be 0 if the window or textbox is resized.  Causes a UE when creating a Bitmap.
				return;
			}
			//Clear out old lines from last draw.
			List<MatchOD> listVisWords=new List<MatchOD>();
			List<int> listLineHeights=ClearWavyLines(listVisWords:listVisWords);
			//Skip if there aren't any words.
			if(listVisWords.Count==0) {
				return;
			}
			List<MatchOD> listMisspelled=new List<MatchOD>();
			foreach(MatchOD wordCur in listVisWords) {
				//We try and store words in our internal dictionary to speed up spelling lookup.
				if(_dictAllWords.ContainsKey(wordCur.Value)) {
					//If it's spelled right, next word.
					if(_dictAllWords[wordCur.Value]!=SpellingType.Incorrect) {
						continue;
					}
					//If we can't find the current casing, we try and find it's lower case version from the custom spelling dictionary
					else if(_dictAllWords.ContainsKey(wordCur.Value.ToLower())) {
						if(_dictAllWords[wordCur.Value.ToLower()]==SpellingType.Custom) {
							continue;
						}
					}
					listMisspelled.Add(wordCur);
				}
				else {//A word we have not checked yet.
					//When looking in Hunspell we care about casing, but with our custom dictionary we don't.
					//The word as they typed it was not in the correct list, but lower case version is,
					//see if the casing as they typed it is correct by Hunspell ("google" is incorrect but "Google" is correct)
					SpellingType wordType;
					string word=wordCur.Value;
					if(HunspellGlobal.Spell(wordCur.Value)) {
						wordType=SpellingType.HunspellExact;
					}
					else if(HunspellGlobal.Spell(wordCur.Value.ToLower()) ) {
						wordType=SpellingType.HunspellLower;
					}
					else if(DictCustoms.GetFirstOrDefault(x => x.WordText.ToLower()==wordCur.Value.ToLower())!=null) {
						wordType=SpellingType.Custom;
						word=word.ToLower();
					}
					else {
						wordType=SpellingType.Incorrect;
					}
					//If we don't have it in our dictionary yet, we check the word and add it and store if it's correct.
					_dictAllWords.TryAdd(word,wordType);
					if(wordType!=SpellingType.Incorrect) {
						continue;//Is correct
					}
					else {
						//If it is't incorrect add it to both our lists.
						listMisspelled.Add(wordCur);
					}
				}
			}
			//If we have no lines to draw we return before we create the graphics objects.
			//This will happen often when a form it loaded with blank data in the odtextbox.
			if(listMisspelled.Count==0) {
				return;
			}
			//Now we draw all the new lines to the textbox.
			using(Bitmap bitmapOverlay=new Bitmap(this.Width,this.Height)) {
				BufferGraphics?.Dispose();
				BufferGraphics=Graphics.FromImage(bitmapOverlay);
				BufferGraphics.Clear(Color.Transparent);//Remove white and replace with transparent so we don't cover the text in the rich text box.
				//This draws lines on the BufferGraphics and bitmapOverlay using our list of incorrect words.
				foreach(MatchOD word in listMisspelled) {
					DrawWave(word,listLineHeights);
				}
				//DrawLines drew the underlines we needed, so now we apply it to the textbox.
				using(Graphics graphicsTextBox=Graphics.FromHwnd(this.Handle)) {
					graphicsTextBox.DrawImageUnscaled(bitmapOverlay,0,0);
				}
			}
		}

		///<summary>Returns a list ofMatchOD objects describing the currently visible in the control.  It will include lines that are half-visible 
		///because of scrolling.  Does the same filtering as GetWords()</summary>
		private List<MatchOD> GetVisibleWords(List<int> listLineHeights) {
			//The start index is also our offset from the start of the text.
			//The minimum value returned is 0.  If the point is above the text, it will default to 0.
			int startIndex=this.GetCharIndexFromPosition(new Point(0,0));
			int y=this.GetPositionFromCharIndex(startIndex).Y;
			for(int i=this.GetLineFromCharIndex(startIndex);i<listLineHeights.Count && y<this.Height;i++) {
				int h=listLineHeights[i];
				if(y+h>=this.Height) {//If next line is past vertical end of box.
					break;//The current line is the last visible or partially visible line.
				}
				y+=h;
			}
			//Add one to the end index so we capture the last character. e.g. [visible tex]t instead of [visible text] 
			//If there's only one character, the endindex would be 0 instead of 1
			int endIndex=this.GetCharIndexFromPosition(new Point(this.Width,y))+1;
			if(endIndex>Text.Length) {
				endIndex=Text.Length;
			}
			string visibleText=Text.Substring(startIndex,endIndex-startIndex);			
			return GetWords(visibleText,startIndex);
		}
		#endregion SpellCheck

		///<summary></summary>
		private List<MatchOD> GetWords(string input,int offset=0) {
			List<MatchOD> wordList=new List<MatchOD>();
			MatchCollection mc=Regex.Matches(input,@"(\S+)");//use Regex.Matches because our matches include the index within our text for underlining
			foreach(Match m in mc) {
				Group g=m.Groups[0];//Group 0 is the entire match
				if(g.Value.Length<2) {//only allow 'words' that are at least two chars long, 1 char 'words' are assumed spelled correctly
					continue;
				}
				MatchOD word=new MatchOD();
				word.StartIndex=g.Index+offset;//this index is the index within Text of the first char of this word (match)
				word.Value=g.Value;
				//loop through starting at the beginning of word looking for first letter or digit
				while(word.Value.Length>1 && !Char.IsLetterOrDigit(word.Value[0])) {
					word.Value=word.Value.Substring(1);
					word.StartIndex++;
				}
				//loop through starting at the last char looking for the last letter or digit
				while(word.Value.Length>1 && !Char.IsLetterOrDigit(word.Value[word.Value.Length-1])) {
					word.Value=word.Value.Substring(0,word.Value.Length-1);
				}
				if(word.Value.Length>1) {
					if(Regex.IsMatch(word.Value,@"[^a-zA-Z\'\-]")) {
						continue;
					}
					wordList.Add(word);
				}
			}
			return wordList;
		}

		///<summary>Returns a list of line heights in order of line index. The widthOverride parameter should only
		///be explicitly set if the control is in the middle of resizing. this.Size is stale when calculating
		///line heights in the middle of a content resize event.</summary>
		private List<int> GetLineHeights(int widthOverride=-1) {
			using(RichTextBox rtb=new RichTextBox()) {
				rtb.Rtf=this.Rtf;
				rtb.Size=new Size((widthOverride==-1 ? this.Size.Width : widthOverride),this.Size.Height);
				if(!rtb.Text.EndsWith("\r\n\t")) {
					rtb.AppendText("\r\n\t");//This will allow us to get the Top of the fake line, which is the bottom of the last line of real text.
				}
				List<RichTextLineInfo> listLines=GraphicsHelper.GetTextSheetDisplayLines(rtb,-1,-1);
				List<int> listLineHeights=new List<int>();
				for(int i=0;i<listLines.Count-1;i++) {
					//Top of next line minus top of current line will give us the height of the current line.
					listLineHeights.Add(listLines[i+1].Top-listLines[i].Top);
				}
				return listLineHeights;
			}
		}

		private void DrawWave(MatchOD match,List<int> listLineHeights) {
			int startLineIndex=GetLineFromCharIndex(match.StartIndex);
			int startLineHeight=listLineHeights[startLineIndex];
			Point start=this.GetPositionFromCharIndex(match.StartIndex);//accounts for scroll position
			Point end=this.GetPositionFromCharIndex(match.StartIndex+match.Value.Length);//accounts for scroll position
			start.Y=start.Y+startLineHeight;//move from top of line to bottom of line
			end.Y=end.Y+startLineHeight;//move from top of line to bottom of line
			if(start.Y<=4 || start.Y>=this.Height) {//Don't draw lines for text which is currently not visible.
				return;
			}
			Pen pen=Pens.Red;
			//Misspelled word spans multiple lines.  This should never actually happen as word wrapping
			//does not allow this scenario to happen and ODTextBox defaults word wrapping to 'true'.
			//The only exception is words which are longer than the line, but we are ignoring this case for now (per Nathan).
			if(end.Y>start.Y) {
				int lineIndex=startLineIndex;
				Point tempEnd=start;
				tempEnd.X=this.Width;
				while(tempEnd.Y<=end.Y && lineIndex<listLineHeights.Count) {//One line at a time.
					if((tempEnd.X-start.X)>4) {//Only draw wavy line if mispelled word is at least 4 pixels wide, otherwise draw straight line
						List<Point> listPoints=new List<Point>();
						for(int i=start.X;i<=(tempEnd.X-2);i=i+4) {
							listPoints.Add(new Point(i,start.Y));
							listPoints.Add(new Point(i+2,start.Y+1));
						}
						BufferGraphics.DrawLines(pen,listPoints.ToArray());
					}
					else {
						BufferGraphics.DrawLine(pen,start,end);
					}
					start.X=1;
					//There is a known issue where if a word spans more than 1 line, the fontheight will only calculate correctly for
					//the first line. The second line's fontheight will not recalculate correctly and will use the first line's static value.
					//Per Nathan we are ignoring this case. If we do want to fix it in the future, this is the spot.
					//lineIndex needs to be updated to use the index of the current line the word is on.
					start.Y=start.Y+listLineHeights[lineIndex];
					tempEnd.Y=start.Y;
					if(tempEnd.Y==end.Y) {//We incremented to the next line and this is the last line of the mispelled word
						tempEnd.X=end.X;
					}
					else {//not the last line of mispelled word, so draw wavy line to end of this line
						tempEnd.X=this.Width;
					}
					lineIndex++;
				}
			}
			else {//end.Y==start.Y
				if((end.X-start.X)>4) {
					List<Point> listPoints=new List<Point>();
					for(int i=start.X;i<=(end.X-2);i+=4) {//Only draw wavy line if misspelled word is at least 4 pixels wide, otherwise draw straight line.
						listPoints.Add(new Point(i,start.Y));
						listPoints.Add(new Point(i+2,start.Y+1));
					}
					BufferGraphics.DrawLines(pen,listPoints.ToArray());
				}
				else {
					BufferGraphics.DrawLine(pen,start,end);
				}
			}
		}

		private void ShowFullDialog() {
			FormQuickPaste FormQ=new FormQuickPaste();
			FormQ.TextToFill=this;
			FormQ.QuickType=quickPasteType;
			FormQ.ShowDialog();
		}

		private void InsertDate() {
			SelectedText=DateTime.Today.ToShortDateString();
		}

		///<summary>Analogous to a Match.  We use it to keep track of words that we find and their location within the larger string.</summary>
		public class MatchOD {
			//This is the 'word' for this match
			public string Value="";
			//This is the starting index of the first char of the 'word' within the full textbox text
			public int StartIndex=0;
		}

		///<summary>Used to determine if a word is correct and by which spelling dictionary.</summary>
		private enum SpellingType {
			Incorrect,
			HunspellExact,
			HunspellLower,
			Custom
		}
	}
}