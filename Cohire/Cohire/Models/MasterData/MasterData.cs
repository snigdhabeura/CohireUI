using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Cohire.Models.MasterData
{
    public class Masterdataoperation
    {
        private static Masterdataoperation instance = null;
        private static readonly object padlock = new object();
        private static string connectionString = string.Empty;
        public static Masterdataoperation Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new Masterdataoperation();
                        connectionString = "Server=.;Database=Cohire;Integrated Security=true;MultipleActiveResultSets=true;";
                    }
                    return instance;
                }
            }
        }

        public async Task<string> GetMasterDataAsync(string tableName)
        {
            SqlConnection azureSQLDb = null;
            string data = null;
            try
            {
                if (!string.IsNullOrEmpty(tableName))
                {
                    using (azureSQLDb = new SqlConnection(connectionString))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                        SqlCommand cmd = new SqlCommand(""+ tableName + "", azureSQLDb);
                        data = (string)await cmd.ExecuteScalarAsync();
                    }
                }
                return data;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally { azureSQLDb.Close(); }
        }
    }
}
