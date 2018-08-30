//This file is automatically generated.
//Do not attempt to make changes to this file because the changes will be erased and overwritten.
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;

namespace OpenDentBusiness.Crud{
	public class DepositCrud {
		///<summary>Gets one Deposit object from the database using the primary key.  Returns null if not found.</summary>
		public static Deposit SelectOne(long depositNum){
			string command="SELECT * FROM deposit "
				+"WHERE DepositNum = "+POut.Long(depositNum);
			List<Deposit> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets one Deposit object from the database using a query.</summary>
		public static Deposit SelectOne(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<Deposit> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets a list of Deposit objects from the database using a query.</summary>
		public static List<Deposit> SelectMany(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<Deposit> list=TableToList(Db.GetTable(command));
			return list;
		}

		///<summary>Converts a DataTable to a list of objects.</summary>
		public static List<Deposit> TableToList(DataTable table){
			List<Deposit> retVal=new List<Deposit>();
			Deposit deposit;
			foreach(DataRow row in table.Rows) {
				deposit=new Deposit();
				deposit.DepositNum       = PIn.Long  (row["DepositNum"].ToString());
				deposit.DateDeposit      = PIn.Date  (row["DateDeposit"].ToString());
				deposit.BankAccountInfo  = PIn.String(row["BankAccountInfo"].ToString());
				deposit.Amount           = PIn.Double(row["Amount"].ToString());
				deposit.Memo             = PIn.String(row["Memo"].ToString());
				deposit.Batch            = PIn.String(row["Batch"].ToString());
				deposit.DepositAccountNum= PIn.Long  (row["DepositAccountNum"].ToString());
				retVal.Add(deposit);
			}
			return retVal;
		}

		///<summary>Converts a list of Deposit into a DataTable.</summary>
		public static DataTable ListToTable(List<Deposit> listDeposits,string tableName="") {
			if(string.IsNullOrEmpty(tableName)) {
				tableName="Deposit";
			}
			DataTable table=new DataTable(tableName);
			table.Columns.Add("DepositNum");
			table.Columns.Add("DateDeposit");
			table.Columns.Add("BankAccountInfo");
			table.Columns.Add("Amount");
			table.Columns.Add("Memo");
			table.Columns.Add("Batch");
			table.Columns.Add("DepositAccountNum");
			foreach(Deposit deposit in listDeposits) {
				table.Rows.Add(new object[] {
					POut.Long  (deposit.DepositNum),
					POut.DateT (deposit.DateDeposit,false),
					            deposit.BankAccountInfo,
					POut.Double(deposit.Amount),
					            deposit.Memo,
					            deposit.Batch,
					POut.Long  (deposit.DepositAccountNum),
				});
			}
			return table;
		}

		///<summary>Inserts one Deposit into the database.  Returns the new priKey.</summary>
		public static long Insert(Deposit deposit){
			if(DataConnection.DBtype==DatabaseType.Oracle) {
				deposit.DepositNum=DbHelper.GetNextOracleKey("deposit","DepositNum");
				int loopcount=0;
				while(loopcount<100){
					try {
						return Insert(deposit,true);
					}
					catch(Oracle.ManagedDataAccess.Client.OracleException ex){
						if(ex.Number==1 && ex.Message.ToLower().Contains("unique constraint") && ex.Message.ToLower().Contains("violated")){
							deposit.DepositNum++;
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
				return Insert(deposit,false);
			}
		}

		///<summary>Inserts one Deposit into the database.  Provides option to use the existing priKey.</summary>
		public static long Insert(Deposit deposit,bool useExistingPK){
			if(!useExistingPK && PrefC.RandomKeys) {
				deposit.DepositNum=ReplicationServers.GetKey("deposit","DepositNum");
			}
			string command="INSERT INTO deposit (";
			if(useExistingPK || PrefC.RandomKeys) {
				command+="DepositNum,";
			}
			command+="DateDeposit,BankAccountInfo,Amount,Memo,Batch,DepositAccountNum) VALUES(";
			if(useExistingPK || PrefC.RandomKeys) {
				command+=POut.Long(deposit.DepositNum)+",";
			}
			command+=
				     POut.Date  (deposit.DateDeposit)+","
				+    DbHelper.ParamChar+"paramBankAccountInfo,"
				+"'"+POut.Double(deposit.Amount)+"',"
				+"'"+POut.String(deposit.Memo)+"',"
				+"'"+POut.String(deposit.Batch)+"',"
				+    POut.Long  (deposit.DepositAccountNum)+")";
			if(deposit.BankAccountInfo==null) {
				deposit.BankAccountInfo="";
			}
			OdSqlParameter paramBankAccountInfo=new OdSqlParameter("paramBankAccountInfo",OdDbType.Text,POut.StringParam(deposit.BankAccountInfo));
			if(useExistingPK || PrefC.RandomKeys) {
				Db.NonQ(command,paramBankAccountInfo);
			}
			else {
				deposit.DepositNum=Db.NonQ(command,true,"DepositNum","deposit",paramBankAccountInfo);
			}
			return deposit.DepositNum;
		}

		///<summary>Inserts one Deposit into the database.  Returns the new priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(Deposit deposit){
			if(DataConnection.DBtype==DatabaseType.MySql) {
				return InsertNoCache(deposit,false);
			}
			else {
				if(DataConnection.DBtype==DatabaseType.Oracle) {
					deposit.DepositNum=DbHelper.GetNextOracleKey("deposit","DepositNum"); //Cacheless method
				}
				return InsertNoCache(deposit,true);
			}
		}

		///<summary>Inserts one Deposit into the database.  Provides option to use the existing priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(Deposit deposit,bool useExistingPK){
			bool isRandomKeys=Prefs.GetBoolNoCache(PrefName.RandomPrimaryKeys);
			string command="INSERT INTO deposit (";
			if(!useExistingPK && isRandomKeys) {
				deposit.DepositNum=ReplicationServers.GetKeyNoCache("deposit","DepositNum");
			}
			if(isRandomKeys || useExistingPK) {
				command+="DepositNum,";
			}
			command+="DateDeposit,BankAccountInfo,Amount,Memo,Batch,DepositAccountNum) VALUES(";
			if(isRandomKeys || useExistingPK) {
				command+=POut.Long(deposit.DepositNum)+",";
			}
			command+=
				     POut.Date  (deposit.DateDeposit)+","
				+    DbHelper.ParamChar+"paramBankAccountInfo,"
				+"'"+POut.Double(deposit.Amount)+"',"
				+"'"+POut.String(deposit.Memo)+"',"
				+"'"+POut.String(deposit.Batch)+"',"
				+    POut.Long  (deposit.DepositAccountNum)+")";
			if(deposit.BankAccountInfo==null) {
				deposit.BankAccountInfo="";
			}
			OdSqlParameter paramBankAccountInfo=new OdSqlParameter("paramBankAccountInfo",OdDbType.Text,POut.StringParam(deposit.BankAccountInfo));
			if(useExistingPK || isRandomKeys) {
				Db.NonQ(command,paramBankAccountInfo);
			}
			else {
				deposit.DepositNum=Db.NonQ(command,true,"DepositNum","deposit",paramBankAccountInfo);
			}
			return deposit.DepositNum;
		}

		///<summary>Updates one Deposit in the database.</summary>
		public static void Update(Deposit deposit){
			string command="UPDATE deposit SET "
				+"DateDeposit      =  "+POut.Date  (deposit.DateDeposit)+", "
				+"BankAccountInfo  =  "+DbHelper.ParamChar+"paramBankAccountInfo, "
				+"Amount           = '"+POut.Double(deposit.Amount)+"', "
				+"Memo             = '"+POut.String(deposit.Memo)+"', "
				+"Batch            = '"+POut.String(deposit.Batch)+"', "
				+"DepositAccountNum=  "+POut.Long  (deposit.DepositAccountNum)+" "
				+"WHERE DepositNum = "+POut.Long(deposit.DepositNum);
			if(deposit.BankAccountInfo==null) {
				deposit.BankAccountInfo="";
			}
			OdSqlParameter paramBankAccountInfo=new OdSqlParameter("paramBankAccountInfo",OdDbType.Text,POut.StringParam(deposit.BankAccountInfo));
			Db.NonQ(command,paramBankAccountInfo);
		}

		///<summary>Updates one Deposit in the database.  Uses an old object to compare to, and only alters changed fields.  This prevents collisions and concurrency problems in heavily used tables.  Returns true if an update occurred.</summary>
		public static bool Update(Deposit deposit,Deposit oldDeposit){
			string command="";
			if(deposit.DateDeposit.Date != oldDeposit.DateDeposit.Date) {
				if(command!=""){ command+=",";}
				command+="DateDeposit = "+POut.Date(deposit.DateDeposit)+"";
			}
			if(deposit.BankAccountInfo != oldDeposit.BankAccountInfo) {
				if(command!=""){ command+=",";}
				command+="BankAccountInfo = "+DbHelper.ParamChar+"paramBankAccountInfo";
			}
			if(deposit.Amount != oldDeposit.Amount) {
				if(command!=""){ command+=",";}
				command+="Amount = '"+POut.Double(deposit.Amount)+"'";
			}
			if(deposit.Memo != oldDeposit.Memo) {
				if(command!=""){ command+=",";}
				command+="Memo = '"+POut.String(deposit.Memo)+"'";
			}
			if(deposit.Batch != oldDeposit.Batch) {
				if(command!=""){ command+=",";}
				command+="Batch = '"+POut.String(deposit.Batch)+"'";
			}
			if(deposit.DepositAccountNum != oldDeposit.DepositAccountNum) {
				if(command!=""){ command+=",";}
				command+="DepositAccountNum = "+POut.Long(deposit.DepositAccountNum)+"";
			}
			if(command==""){
				return false;
			}
			if(deposit.BankAccountInfo==null) {
				deposit.BankAccountInfo="";
			}
			OdSqlParameter paramBankAccountInfo=new OdSqlParameter("paramBankAccountInfo",OdDbType.Text,POut.StringParam(deposit.BankAccountInfo));
			command="UPDATE deposit SET "+command
				+" WHERE DepositNum = "+POut.Long(deposit.DepositNum);
			Db.NonQ(command,paramBankAccountInfo);
			return true;
		}

		///<summary>Returns true if Update(Deposit,Deposit) would make changes to the database.
		///Does not make any changes to the database and can be called before remoting role is checked.</summary>
		public static bool UpdateComparison(Deposit deposit,Deposit oldDeposit) {
			if(deposit.DateDeposit.Date != oldDeposit.DateDeposit.Date) {
				return true;
			}
			if(deposit.BankAccountInfo != oldDeposit.BankAccountInfo) {
				return true;
			}
			if(deposit.Amount != oldDeposit.Amount) {
				return true;
			}
			if(deposit.Memo != oldDeposit.Memo) {
				return true;
			}
			if(deposit.Batch != oldDeposit.Batch) {
				return true;
			}
			if(deposit.DepositAccountNum != oldDeposit.DepositAccountNum) {
				return true;
			}
			return false;
		}

		///<summary>Deletes one Deposit from the database.</summary>
		public static void Delete(long depositNum){
			string command="DELETE FROM deposit "
				+"WHERE DepositNum = "+POut.Long(depositNum);
			Db.NonQ(command);
		}

	}
}