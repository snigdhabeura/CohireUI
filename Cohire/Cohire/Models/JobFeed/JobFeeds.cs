using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Linq;
using Cohire.Models.CommonOperation;

namespace Cohire.Models.JobFeed
{
    public class JobFeeds
    {
        private static JobFeeds instance = null;
        private static readonly object padlock = new object();
        private static string connectionString = string.Empty;
        public static JobFeeds Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new JobFeeds();
                        connectionString = GetConnectionString.Instance.ReturnConnectionString();
                    }
                    return instance;
                }
            }
        }
        public  string GetJobFeeds()
        {
              
               SqlConnection azureSQLDb = null;
            try
            {
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                        string query = "SELECT job = '['+STUFF(( SELECT ',' + JobJson FROM [JobPost]   order by CreatedDate desc FOR XML PATH('') ), 1, 1,'')+']'";
                        SqlCommand cmd = new SqlCommand(query, azureSQLDb);
                        var data = cmd.ExecuteScalar().ToString();
                        return data;
                     
                }
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                azureSQLDb.Close();
            }
        }

        public string GetJobFeeds(string jobID)
        {

            SqlConnection azureSQLDb = null;
            try
            {
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    if (!string.IsNullOrEmpty(jobID))
                    {
                        string query = "select JobJson from JobPost  where ChJobID='" + jobID + "'";
                        SqlCommand cmd = new SqlCommand(query, azureSQLDb);
                        var data = cmd.ExecuteScalar().ToString();
                        return data;
                    }
                    else
                    {
                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                azureSQLDb.Close();
            }
        }
    }
}
