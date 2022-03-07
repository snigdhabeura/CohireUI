using Cohire.Models.CommonOperation;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Cohire.Models.Profile
{
    public sealed class ProfileDB
    {
        private static ProfileDB instance = null;
        private static readonly object padlock = new object();
        private static string connectionString = string.Empty;
        public static ProfileDB Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new ProfileDB();
                        connectionString = GetConnectionString.Instance.ReturnConnectionString();
                    }
                    return instance;
                }
            }
        }

        public async Task<List<string>> GetCompanyNames()
        {
            SqlConnection azureSQLDb = null;
            List<string> data = null;
            try
            {

                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("SELECT STUFF((SELECT ',\"' + [CompanyName] + '\"' FROM[Company_Master] FOR XML PATH('') ), 1, 1, '[') + ']' As JsonOutput", azureSQLDb);
                    var skilldata = await cmd.ExecuteScalarAsync();
                    data = JsonConvert.DeserializeObject<List<string>>(skilldata.ToString());
                    //data = data.Where(x=> x.Contains(skill,StringComparison.OrdinalIgnoreCase)).ToList();
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
