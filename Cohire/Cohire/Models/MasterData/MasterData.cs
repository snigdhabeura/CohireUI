﻿using Cohire.Models.CommonOperation;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Cohire.Models.MasterData
{

    public class Job_Category
    {
        public int CategoryId { get;set;}   
        public string Category_Name { get;set;}
    }
    public class Job_EmploymentType
    {
        public int EmploymentId { get; set; }
        public string Employment_Type { get; set; }
    }
    public class Job_Expernice
    {
        public int ExperineceId { get; set; }
        public string Exp_Range { get; set; }
    }


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
                        connectionString = GetConnectionString.Instance.ReturnConnectionString();
                    }
                    return instance;
                }
            }
        }

        public async Task<List<T>>GetMasterDataAsync<T>(string tableName)
        {
            SqlConnection azureSQLDb = null;
            try
            {
                if (!string.IsNullOrEmpty(tableName))
                {
                    using (azureSQLDb = new SqlConnection(connectionString))
                    {
                        if (azureSQLDb.State == System.Data.ConnectionState.Closed)
                            azureSQLDb.Open();
                            SqlCommand cmd = new SqlCommand(""+ tableName + "", azureSQLDb);
                            var data = (string)await cmd.ExecuteScalarAsync();
                        var result = JsonConvert.DeserializeObject<List<T>>(data);
                        return result;
                    }
                }
                else
                {
                    return null;
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
