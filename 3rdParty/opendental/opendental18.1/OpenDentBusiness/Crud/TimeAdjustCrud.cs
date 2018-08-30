//This file is automatically generated.
//Do not attempt to make changes to this file because the changes will be erased and overwritten.
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;

namespace OpenDentBusiness.Crud{
	public class TimeAdjustCrud {
		///<summary>Gets one TimeAdjust object from the database using the primary key.  Returns null if not found.</summary>
		public static TimeAdjust SelectOne(long timeAdjustNum){
			string command="SELECT * FROM timeadjust "
				+"WHERE TimeAdjustNum = "+POut.Long(timeAdjustNum);
			List<TimeAdjust> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets one TimeAdjust object from the database using a query.</summary>
		public static TimeAdjust SelectOne(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<TimeAdjust> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets a list of TimeAdjust objects from the database using a query.</summary>
		public static List<TimeAdjust> SelectMany(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<TimeAdjust> list=TableToList(Db.GetTable(command));
			return list;
		}

		///<summary>Converts a DataTable to a list of objects.</summary>
		public static List<TimeAdjust> TableToList(DataTable table){
			List<TimeAdjust> retVal=new List<TimeAdjust>();
			TimeAdjust timeAdjust;
			foreach(DataRow row in table.Rows) {
				timeAdjust=new TimeAdjust();
				timeAdjust.TimeAdjustNum= PIn.Long  (row["TimeAdjustNum"].ToString());
				timeAdjust.EmployeeNum  = PIn.Long  (row["EmployeeNum"].ToString());
				timeAdjust.TimeEntry    = PIn.DateT (row["TimeEntry"].ToString());
				timeAdjust.RegHours     = PIn.TSpan (row["RegHours"].ToString());
				timeAdjust.OTimeHours   = PIn.TSpan (row["OTimeHours"].ToString());
				timeAdjust.Note         = PIn.String(row["Note"].ToString());
				timeAdjust.IsAuto       = PIn.Bool  (row["IsAuto"].ToString());
				timeAdjust.ClinicNum    = PIn.Long  (row["ClinicNum"].ToString());
				retVal.Add(timeAdjust);
			}
			return retVal;
		}

		///<summary>Converts a list of TimeAdjust into a DataTable.</summary>
		public static DataTable ListToTable(List<TimeAdjust> listTimeAdjusts,string tableName="") {
			if(string.IsNullOrEmpty(tableName)) {
				tableName="TimeAdjust";
			}
			DataTable table=new DataTable(tableName);
			table.Columns.Add("TimeAdjustNum");
			table.Columns.Add("EmployeeNum");
			table.Columns.Add("TimeEntry");
			table.Columns.Add("RegHours");
			table.Columns.Add("OTimeHours");
			table.Columns.Add("Note");
			table.Columns.Add("IsAuto");
			table.Columns.Add("ClinicNum");
			foreach(TimeAdjust timeAdjust in listTimeAdjusts) {
				table.Rows.Add(new object[] {
					POut.Long  (timeAdjust.TimeAdjustNum),
					POut.Long  (timeAdjust.EmployeeNum),
					POut.DateT (timeAdjust.TimeEntry,false),
					POut.Time  (timeAdjust.RegHours,false),
					POut.Time  (timeAdjust.OTimeHours,false),
					            timeAdjust.Note,
					POut.Bool  (timeAdjust.IsAuto),
					POut.Long  (timeAdjust.ClinicNum),
				});
			}
			return table;
		}

		///<summary>Inserts one TimeAdjust into the database.  Returns the new priKey.</summary>
		public static long Insert(TimeAdjust timeAdjust){
			if(DataConnection.DBtype==DatabaseType.Oracle) {
				timeAdjust.TimeAdjustNum=DbHelper.GetNextOracleKey("timeadjust","TimeAdjustNum");
				int loopcount=0;
				while(loopcount<100){
					try {
						return Insert(timeAdjust,true);
					}
					catch(Oracle.ManagedDataAccess.Client.OracleException ex){
						if(ex.Number==1 && ex.Message.ToLower().Contains("unique constraint") && ex.Message.ToLower().Contains("violated")){
							timeAdjust.TimeAdjustNum++;
							loopcount++;
						}
						else{
							throw ex;
						}
					}
				}
				throw new ApplicationException("Insert failed.  Could not generate primary key.");
			}
			else {
				return Insert(timeAdjust,false);
			}
		}

		///<summary>Inserts one TimeAdjust into the database.  Provides option to use the existing priKey.</summary>
		public static long Insert(TimeAdjust timeAdjust,bool useExistingPK){
			if(!useExistingPK && PrefC.RandomKeys) {
				timeAdjust.TimeAdjustNum=ReplicationServers.GetKey("timeadjust","TimeAdjustNum");
			}
			string command="INSERT INTO timeadjust (";
			if(useExistingPK || PrefC.RandomKeys) {
				command+="TimeAdjustNum,";
			}
			command+="EmployeeNum,TimeEntry,RegHours,OTimeHours,Note,IsAuto,ClinicNum) VALUES(";
			if(useExistingPK || PrefC.RandomKeys) {
				command+=POut.Long(timeAdjust.TimeAdjustNum)+",";
			}
			command+=
				     POut.Long  (timeAdjust.EmployeeNum)+","
				+    POut.DateT (timeAdjust.TimeEntry)+","
				+"'"+POut.TSpan (timeAdjust.RegHours)+"',"
				+"'"+POut.TSpan (timeAdjust.OTimeHours)+"',"
				+    DbHelper.ParamChar+"paramNote,"
				+    POut.Bool  (timeAdjust.IsAuto)+","
				+    POut.Long  (timeAdjust.ClinicNum)+")";
			if(timeAdjust.Note==null) {
				timeAdjust.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(timeAdjust.Note));
			if(useExistingPK || PrefC.RandomKeys) {
				Db.NonQ(command,paramNote);
			}
			else {
				timeAdjust.TimeAdjustNum=Db.NonQ(command,true,"TimeAdjustNum","timeAdjust",paramNote);
			}
			return timeAdjust.TimeAdjustNum;
		}

		///<summary>Inserts one TimeAdjust into the database.  Returns the new priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(TimeAdjust timeAdjust){
			if(DataConnection.DBtype==DatabaseType.MySql) {
				return InsertNoCache(timeAdjust,false);
			}
			else {
				if(DataConnection.DBtype==DatabaseType.Oracle) {
					timeAdjust.TimeAdjustNum=DbHelper.GetNextOracleKey("timeadjust","TimeAdjustNum"); //Cacheless method
				}
				return InsertNoCache(timeAdjust,true);
			}
		}

		///<summary>Inserts one TimeAdjust into the database.  Provides option to use the existing priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(TimeAdjust timeAdjust,bool useExistingPK){
			bool isRandomKeys=Prefs.GetBoolNoCache(PrefName.RandomPrimaryKeys);
			string command="INSERT INTO timeadjust (";
			if(!useExistingPK && isRandomKeys) {
				timeAdjust.TimeAdjustNum=ReplicationServers.GetKeyNoCache("timeadjust","TimeAdjustNum");
			}
			if(isRandomKeys || useExistingPK) {
				command+="TimeAdjustNum,";
			}
			command+="EmployeeNum,TimeEntry,RegHours,OTimeHours,Note,IsAuto,ClinicNum) VALUES(";
			if(isRandomKeys || useExistingPK) {
				command+=POut.Long(timeAdjust.TimeAdjustNum)+",";
			}
			command+=
				     POut.Long  (timeAdjust.EmployeeNum)+","
				+    POut.DateT (timeAdjust.TimeEntry)+","
				+"'"+POut.TSpan (timeAdjust.RegHours)+"',"
				+"'"+POut.TSpan (timeAdjust.OTimeHours)+"',"
				+    DbHelper.ParamChar+"paramNote,"
				+    POut.Bool  (timeAdjust.IsAuto)+","
				+    POut.Long  (timeAdjust.ClinicNum)+")";
			if(timeAdjust.Note==null) {
				timeAdjust.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(timeAdjust.Note));
			if(useExistingPK || isRandomKeys) {
				Db.NonQ(command,paramNote);
			}
			else {
				timeAdjust.TimeAdjustNum=Db.NonQ(command,true,"TimeAdjustNum","timeAdjust",paramNote);
			}
			return timeAdjust.TimeAdjustNum;
		}

		///<summary>Updates one TimeAdjust in the database.</summary>
		public static void Update(TimeAdjust timeAdjust){
			string command="UPDATE timeadjust SET "
				+"EmployeeNum  =  "+POut.Long  (timeAdjust.EmployeeNum)+", "
				+"TimeEntry    =  "+POut.DateT (timeAdjust.TimeEntry)+", "
				+"RegHours     = '"+POut.TSpan (timeAdjust.RegHours)+"', "
				+"OTimeHours   = '"+POut.TSpan (timeAdjust.OTimeHours)+"', "
				+"Note         =  "+DbHelper.ParamChar+"paramNote, "
				+"IsAuto       =  "+POut.Bool  (timeAdjust.IsAuto)+", "
				+"ClinicNum    =  "+POut.Long  (timeAdjust.ClinicNum)+" "
				+"WHERE TimeAdjustNum = "+POut.Long(timeAdjust.TimeAdjustNum);
			if(timeAdjust.Note==null) {
				timeAdjust.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(timeAdjust.Note));
			Db.NonQ(command,paramNote);
		}

		///<summary>Updates one TimeAdjust in the database.  Uses an old object to compare to, and only alters changed fields.  This prevents collisions and concurrency problems in heavily used tables.  Returns true if an update occurred.</summary>
		public static bool Update(TimeAdjust timeAdjust,TimeAdjust oldTimeAdjust){
			string command="";
			if(timeAdjust.EmployeeNum != oldTimeAdjust.EmployeeNum) {
				if(command!=""){ command+=",";}
				command+="EmployeeNum = "+POut.Long(timeAdjust.EmployeeNum)+"";
			}
			if(timeAdjust.TimeEntry != oldTimeAdjust.TimeEntry) {
				if(command!=""){ command+=",";}
				command+="TimeEntry = "+POut.DateT(timeAdjust.TimeEntry)+"";
			}
			if(timeAdjust.RegHours != oldTimeAdjust.RegHours) {
				if(command!=""){ command+=",";}
				command+="RegHours = '"+POut.TSpan (timeAdjust.RegHours)+"'";
			}
			if(timeAdjust.OTimeHours != oldTimeAdjust.OTimeHours) {
				if(command!=""){ command+=",";}
				command+="OTimeHours = '"+POut.TSpan (timeAdjust.OTimeHours)+"'";
			}
			if(timeAdjust.Note != oldTimeAdjust.Note) {
				if(command!=""){ command+=",";}
				command+="Note = "+DbHelper.ParamChar+"paramNote";
			}
			if(timeAdjust.IsAuto != oldTimeAdjust.IsAuto) {
				if(command!=""){ command+=",";}
				command+="IsAuto = "+POut.Bool(timeAdjust.IsAuto)+"";
			}
			if(timeAdjust.ClinicNum != oldTimeAdjust.ClinicNum) {
				if(command!=""){ command+=",";}
				command+="ClinicNum = "+POut.Long(timeAdjust.ClinicNum)+"";
			}
			if(command==""){
				return false;
			}
			if(timeAdjust.Note==null) {
				timeAdjust.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(timeAdjust.Note));
			command="UPDATE timeadjust SET "+command
				+" WHERE TimeAdjustNum = "+POut.Long(timeAdjust.TimeAdjustNum);
			Db.NonQ(command,paramNote);
			return true;
		}

		///<summary>Returns true if Update(TimeAdjust,TimeAdjust) would make changes to the database.
		///Does not make any changes to the database and can be called before remoting role is checked.</summary>
		public static bool UpdateComparison(TimeAdjust timeAdjust,TimeAdjust oldTimeAdjust) {
			if(timeAdjust.EmployeeNum != oldTimeAdjust.EmployeeNum) {
				return true;
			}
			if(timeAdjust.TimeEntry != oldTimeAdjust.TimeEntry) {
				return true;
			}
			if(timeAdjust.RegHours != oldTimeAdjust.RegHours) {
				return true;
			}
			if(timeAdjust.OTimeHours != oldTimeAdjust.OTimeHours) {
				return true;
			}
			if(timeAdjust.Note != oldTimeAdjust.Note) {
				return true;
			}
			if(timeAdjust.IsAuto != oldTimeAdjust.IsAuto) {
				return true;
			}
			if(timeAdjust.ClinicNum != oldTimeAdjust.ClinicNum) {
				return true;
			}
			return false;
		}

		///<summary>Deletes one TimeAdjust from the database.</summary>
		public static void Delete(long timeAdjustNum){
			string command="DELETE FROM timeadjust "
				+"WHERE TimeAdjustNum = "+POut.Long(timeAdjustNum);
			Db.NonQ(command);
		}

	}
}