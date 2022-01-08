using System.Data;
using System;
using System.Data.SqlClient;

namespace Cohire.Model.PostJob
{
    public sealed class PostJobDB
    {
        private static PostJobDB instance = null;
        private static readonly object padlock = new object();
        public static PostJobDB Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new PostJobDB();
                    }
                    return instance;
                }
            }
        }

        public string CreateJobPublic(string JobID, string ChJobID, string PostedByID, string JobJson, string SearchInstance)
        {
            try
            {
                PostedByID = "Shiva";
                string connectionString = "Server=.;Database=Cohire;Integrated Security=true;MultipleActiveResultSets=true;";
                using (SqlConnection azureSQLDb = new SqlConnection(connectionString))
                {
                    if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                        azureSQLDb.Open();
                    SqlCommand cmd = new SqlCommand("[dbo].[CreateJobForPublic]", azureSQLDb);
                    cmd.Parameters.Add("@JobID", SqlDbType.VarChar).Value = JobID;
                    cmd.Parameters.Add("@ChJobID", SqlDbType.VarChar).Value = ChJobID;
                    cmd.Parameters.Add("@PostedByID", SqlDbType.VarChar).Value = PostedByID;
                    cmd.Parameters.Add("@JobJson", SqlDbType.VarChar).Value = JobJson;
                    cmd.Parameters.Add("@SearchInstance", SqlDbType.VarChar).Value = SearchInstance;
                    cmd.CommandType = CommandType.StoredProcedure;
                    return cmd.ExecuteNonQuery().ToString();
                }
            }
            catch (Exception ex)
            {

                return ex.Message + "||" + ex.StackTrace;
            }

        }

    }
}
