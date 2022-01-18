using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using System.Linq;
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
                        connectionString = "Server=.;Database=Cohire;Integrated Security=true;MultipleActiveResultSets=true;";
                    }
                    return instance;
                }
            }
        }
        public  List<string> GetJobFeeds(string jobID="")
        {
            List<string> vs = new List<string>();   
               SqlConnection azureSQLDb = null;
            try
            {
                using (azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    if(!string.IsNullOrEmpty(jobID))
                    {
                        string query = "select JobJson from JobPost  where ChJobID='"+ jobID + "'";
                        SqlCommand cmd = new SqlCommand(query, azureSQLDb);
                        var data = cmd.ExecuteScalar().ToString();
                        vs.Add(data);
                    }
                    else
                    {
                        SqlCommand cmd = new SqlCommand("SELECT job = STUFF(( SELECT '|' + JobJson FROM [JobPost]   order by CreatedDate desc FOR XML PATH('') ), 1, 1, '')", azureSQLDb);
                        var data = cmd.ExecuteScalar().ToString();
                        vs = data.Split('|').ToList();
                    }
                        
                        return vs;
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
