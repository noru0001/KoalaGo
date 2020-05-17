
using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Data;
using System.Data.Common;

namespace KoalaGo.Data
{
    public class DataManager
    {


        public DataTable getKoalaHabitat()
        {

            try
            {
                DatabaseProviderFactory factory = new DatabaseProviderFactory();
                var db = factory.Create("koalaCon");
                var ds = new DataSet();

                string sql = "sp_getKoalaHabitat_based_datefound";
                DbCommand dbCommand = db.GetStoredProcCommand(sql);


                using (IDataReader dataReader = db.ExecuteReader(dbCommand))
                {
                    DataTable table = new DataTable();
                    try
                    {
                        table.Load(dataReader);
                    }
                    catch (Exception ex)
                    {
                        LogManager.writeToLog("getKoalaHabitat sp:\nErr:" + ex.Message);
                        throw ex;
                    }
                    finally
                    {
                        if (dataReader != null)
                        {
                            dataReader.Close();
                            dataReader.Dispose();
                        }
                    }
                    return table;
                }
            }
            catch (Exception ex)
            {
                return null;
            }

        }

        public DataTable getKoalaHabitat_basedon_datefound()
        {

            try
            {
                DatabaseProviderFactory factory = new DatabaseProviderFactory();
                var db = factory.Create("koalaCon");
                var ds = new DataSet();

                string sql = "sp_getKoalaHabitat_based_datefound";
                DbCommand dbCommand = db.GetStoredProcCommand(sql);


                using (IDataReader dataReader = db.ExecuteReader(dbCommand))
                {
                    DataTable table = new DataTable();
                    try
                    {
                        table.Load(dataReader);
                    }
                    catch (Exception ex)
                    {
                        LogManager.writeToLog("sp_getKoalaHabitat_based_datefound sp:\nErr:" + ex.Message);

                        throw ex;
                    }
                    finally
                    {
                        if (dataReader != null)
                        {
                            dataReader.Close();
                            dataReader.Dispose();
                        }
                    }
                    return table;
                }
            }
            catch (Exception ex)
            {
                LogManager.writeToLog("sp_getKoalaHabitat_based_datefound sp:\nErr:" + ex.Message);

                return null;
            }
            finally
            {

            }

        }



        public DataTable getKoalaOrganisations()
        {

            try
            {
                DatabaseProviderFactory factory = new DatabaseProviderFactory();
                var db = factory.Create("koalaCon");
                var ds = new DataSet();

                string sql = "sp_getKoalaOrganisations";
                DbCommand dbCommand = db.GetStoredProcCommand(sql);


                using (IDataReader dataReader = db.ExecuteReader(dbCommand))
                {
                    DataTable table = new DataTable();
                    try
                    {
                        table.Load(dataReader);
                    }
                    catch (Exception ex)
                    {
                        LogManager.writeToLog(ex.Message);
                        throw ex;
                    }
                    finally
                    {
                        if (dataReader != null)
                            dataReader.Close();
                    }
                    return table;
                }
            }
            catch (Exception ex)
            {
                LogManager.writeToLog("sp_getKoalaOrganisations\nErr:" + ex.Message);

                return null;
            }

        }

    }
}