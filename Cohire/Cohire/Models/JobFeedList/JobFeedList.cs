using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Cohire.Models.JobFeedList
{
    public class JobFile
    {
        public string filetype { get; set; }
        public string fileurl { get; set; }
        public string filename { get; set; }
    }

    public class JobFeedList
    {
        public string JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string PostedByName { get; set; }
        public string RoleId { get; set; }
        public string Jobtitle { get; set; }
        public int CategoryID { get; set; }
        public string Category_Name { get; set; }
        public int ExperienceID { get; set; }
        public string Experience_Name { get; set; }
        public int EmploymenttypeID { get; set; }
        public string Employmenttype_Name { get; set; }
        public string Salaryrange { get; set; }
        public string JobDescription { get; set; }
        public bool Is_Job { get; set; }
        public string Ip_Address { get; set; }
        public string Device_Type { get; set; }
        public List<string> city { get; set; }
        public List<string> Skills { get; set; }
        public List<string> JobQuestions { get; set; }
        public List<JobFile> JobFiles { get; set; }
    }
}
