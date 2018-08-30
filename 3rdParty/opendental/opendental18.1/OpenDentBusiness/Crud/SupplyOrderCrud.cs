//This file is automatically generated.
//Do not attempt to make changes to this file because the changes will be erased and overwritten.
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;

namespace OpenDentBusiness.Crud{
	public class SupplyOrderCrud {
		///<summary>Gets one SupplyOrder object from the database using the primary key.  Returns null if not found.</summary>
		public static SupplyOrder SelectOne(long supplyOrderNum){
			string command="SELECT * FROM supplyorder "
				+"WHERE SupplyOrderNum = "+POut.Long(supplyOrderNum);
			List<SupplyOrder> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets one SupplyOrder object from the database using a query.</summary>
		public static SupplyOrder SelectOne(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<SupplyOrder> list=TableToList(Db.GetTable(command));
			if(list.Count==0) {
				return null;
			}
			return list[0];
		}

		///<summary>Gets a list of SupplyOrder objects from the database using a query.</summary>
		public static List<SupplyOrder> SelectMany(string command){
			if(RemotingClient.RemotingRole==RemotingRole.ClientWeb) {
				throw new ApplicationException("Not allowed to send sql directly.  Rewrite the calling class to not use this query:\r\n"+command);
			}
			List<SupplyOrder> list=TableToList(Db.GetTable(command));
			return list;
		}

		///<summary>Converts a DataTable to a list of objects.</summary>
		public static List<SupplyOrder> TableToList(DataTable table){
			List<SupplyOrder> retVal=new List<SupplyOrder>();
			SupplyOrder supplyOrder;
			foreach(DataRow row in table.Rows) {
				supplyOrder=new SupplyOrder();
				supplyOrder.SupplyOrderNum= PIn.Long  (row["SupplyOrderNum"].ToString());
				supplyOrder.SupplierNum   = PIn.Long  (row["SupplierNum"].ToString());
				supplyOrder.DatePlaced    = PIn.Date  (row["DatePlaced"].ToString());
				supplyOrder.Note          = PIn.String(row["Note"].ToString());
				supplyOrder.AmountTotal   = PIn.Double(row["AmountTotal"].ToString());
				retVal.Add(supplyOrder);
			}
			return retVal;
		}

		///<summary>Converts a list of SupplyOrder into a DataTable.</summary>
		public static DataTable ListToTable(List<SupplyOrder> listSupplyOrders,string tableName="") {
			if(string.IsNullOrEmpty(tableName)) {
				tableName="SupplyOrder";
			}
			DataTable table=new DataTable(tableName);
			table.Columns.Add("SupplyOrderNum");
			table.Columns.Add("SupplierNum");
			table.Columns.Add("DatePlaced");
			table.Columns.Add("Note");
			table.Columns.Add("AmountTotal");
			foreach(SupplyOrder supplyOrder in listSupplyOrders) {
				table.Rows.Add(new object[] {
					POut.Long  (supplyOrder.SupplyOrderNum),
					POut.Long  (supplyOrder.SupplierNum),
					POut.DateT (supplyOrder.DatePlaced,false),
					            supplyOrder.Note,
					POut.Double(supplyOrder.AmountTotal),
				});
			}
			return table;
		}

		///<summary>Inserts one SupplyOrder into the database.  Returns the new priKey.</summary>
		public static long Insert(SupplyOrder supplyOrder){
			if(DataConnection.DBtype==DatabaseType.Oracle) {
				supplyOrder.SupplyOrderNum=DbHelper.GetNextOracleKey("supplyorder","SupplyOrderNum");
				int loopcount=0;
				while(loopcount<100){
					try {
						return Insert(supplyOrder,true);
					}
					catch(Oracle.ManagedDataAccess.Client.OracleException ex){
						if(ex.Number==1 && ex.Message.ToLower().Contains("unique constraint") && ex.Message.ToLower().Contains("violated")){
							supplyOrder.SupplyOrderNum++;
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
				return Insert(supplyOrder,false);
			}
		}

		///<summary>Inserts one SupplyOrder into the database.  Provides option to use the existing priKey.</summary>
		public static long Insert(SupplyOrder supplyOrder,bool useExistingPK){
			if(!useExistingPK && PrefC.RandomKeys) {
				supplyOrder.SupplyOrderNum=ReplicationServers.GetKey("supplyorder","SupplyOrderNum");
			}
			string command="INSERT INTO supplyorder (";
			if(useExistingPK || PrefC.RandomKeys) {
				command+="SupplyOrderNum,";
			}
			command+="SupplierNum,DatePlaced,Note,AmountTotal) VALUES(";
			if(useExistingPK || PrefC.RandomKeys) {
				command+=POut.Long(supplyOrder.SupplyOrderNum)+",";
			}
			command+=
				     POut.Long  (supplyOrder.SupplierNum)+","
				+    POut.Date  (supplyOrder.DatePlaced)+","
				+    DbHelper.ParamChar+"paramNote,"
				+"'"+POut.Double(supplyOrder.AmountTotal)+"')";
			if(supplyOrder.Note==null) {
				supplyOrder.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(supplyOrder.Note));
			if(useExistingPK || PrefC.RandomKeys) {
				Db.NonQ(command,paramNote);
			}
			else {
				supplyOrder.SupplyOrderNum=Db.NonQ(command,true,"SupplyOrderNum","supplyOrder",paramNote);
			}
			return supplyOrder.SupplyOrderNum;
		}

		///<summary>Inserts one SupplyOrder into the database.  Returns the new priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(SupplyOrder supplyOrder){
			if(DataConnection.DBtype==DatabaseType.MySql) {
				return InsertNoCache(supplyOrder,false);
			}
			else {
				if(DataConnection.DBtype==DatabaseType.Oracle) {
					supplyOrder.SupplyOrderNum=DbHelper.GetNextOracleKey("supplyorder","SupplyOrderNum"); //Cacheless method
				}
				return InsertNoCache(supplyOrder,true);
			}
		}

		///<summary>Inserts one SupplyOrder into the database.  Provides option to use the existing priKey.  Doesn't use the cache.</summary>
		public static long InsertNoCache(SupplyOrder supplyOrder,bool useExistingPK){
			bool isRandomKeys=Prefs.GetBoolNoCache(PrefName.RandomPrimaryKeys);
			string command="INSERT INTO supplyorder (";
			if(!useExistingPK && isRandomKeys) {
				supplyOrder.SupplyOrderNum=ReplicationServers.GetKeyNoCache("supplyorder","SupplyOrderNum");
			}
			if(isRandomKeys || useExistingPK) {
				command+="SupplyOrderNum,";
			}
			command+="SupplierNum,DatePlaced,Note,AmountTotal) VALUES(";
			if(isRandomKeys || useExistingPK) {
				command+=POut.Long(supplyOrder.SupplyOrderNum)+",";
			}
			command+=
				     POut.Long  (supplyOrder.SupplierNum)+","
				+    POut.Date  (supplyOrder.DatePlaced)+","
				+    DbHelper.ParamChar+"paramNote,"
				+"'"+POut.Double(supplyOrder.AmountTotal)+"')";
			if(supplyOrder.Note==null) {
				supplyOrder.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(supplyOrder.Note));
			if(useExistingPK || isRandomKeys) {
				Db.NonQ(command,paramNote);
			}
			else {
				supplyOrder.SupplyOrderNum=Db.NonQ(command,true,"SupplyOrderNum","supplyOrder",paramNote);
			}
			return supplyOrder.SupplyOrderNum;
		}

		///<summary>Updates one SupplyOrder in the database.</summary>
		public static void Update(SupplyOrder supplyOrder){
			string command="UPDATE supplyorder SET "
				+"SupplierNum   =  "+POut.Long  (supplyOrder.SupplierNum)+", "
				+"DatePlaced    =  "+POut.Date  (supplyOrder.DatePlaced)+", "
				+"Note          =  "+DbHelper.ParamChar+"paramNote, "
				+"AmountTotal   = '"+POut.Double(supplyOrder.AmountTotal)+"' "
				+"WHERE SupplyOrderNum = "+POut.Long(supplyOrder.SupplyOrderNum);
			if(supplyOrder.Note==null) {
				supplyOrder.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(supplyOrder.Note));
			Db.NonQ(command,paramNote);
		}

		///<summary>Updates one SupplyOrder in the database.  Uses an old object to compare to, and only alters changed fields.  This prevents collisions and concurrency problems in heavily used tables.  Returns true if an update occurred.</summary>
		public static bool Update(SupplyOrder supplyOrder,SupplyOrder oldSupplyOrder){
			string command="";
			if(supplyOrder.SupplierNum != oldSupplyOrder.SupplierNum) {
				if(command!=""){ command+=",";}
				command+="SupplierNum = "+POut.Long(supplyOrder.SupplierNum)+"";
			}
			if(supplyOrder.DatePlaced.Date != oldSupplyOrder.DatePlaced.Date) {
				if(command!=""){ command+=",";}
				command+="DatePlaced = "+POut.Date(supplyOrder.DatePlaced)+"";
			}
			if(supplyOrder.Note != oldSupplyOrder.Note) {
				if(command!=""){ command+=",";}
				command+="Note = "+DbHelper.ParamChar+"paramNote";
			}
			if(supplyOrder.AmountTotal != oldSupplyOrder.AmountTotal) {
				if(command!=""){ command+=",";}
				command+="AmountTotal = '"+POut.Double(supplyOrder.AmountTotal)+"'";
			}
			if(command==""){
				return false;
			}
			if(supplyOrder.Note==null) {
				supplyOrder.Note="";
			}
			OdSqlParameter paramNote=new OdSqlParameter("paramNote",OdDbType.Text,POut.StringParam(supplyOrder.Note));
			command="UPDATE supplyorder SET "+command
				+" WHERE SupplyOrderNum = "+POut.Long(supplyOrder.SupplyOrderNum);
			Db.NonQ(command,paramNote);
			return true;
		}

		///<summary>Returns true if Update(SupplyOrder,SupplyOrder) would make changes to the database.
		///Does not make any changes to the database and can be called before remoting role is checked.</summary>
		public static bool UpdateComparison(SupplyOrder supplyOrder,SupplyOrder oldSupplyOrder) {
			if(supplyOrder.SupplierNum != oldSupplyOrder.SupplierNum) {
				return true;
			}
			if(supplyOrder.DatePlaced.Date != oldSupplyOrder.DatePlaced.Date) {
				return true;
			}
			if(supplyOrder.Note != oldSupplyOrder.Note) {
				return true;
			}
			if(supplyOrder.AmountTotal != oldSupplyOrder.AmountTotal) {
				return true;
			}
			return false;
		}

		///<summary>Deletes one SupplyOrder from the database.</summary>
		public static void Delete(long supplyOrderNum){
			string command="DELETE FROM supplyorder "
				+"WHERE SupplyOrderNum = "+POut.Long(supplyOrderNum);
			Db.NonQ(command);
		}

	}
}