using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;

namespace CohireAPI.PostJobs.Model
{
    public class PostJobModel
    {
        public Guid ?JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string RoleId { get; set; }
        public string JobDescription { get; set; }  
        public string Skills { get; set; }
        public string JobQuestions{ get; set; }
        public List<IFormFile> JobFiles { get; set; }

    }

    public class UpdatePostJobModel
    {
        public Guid? JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string RoleId { get; set; }
        public string JobDescription { get; set; }
        public string Skills { get; set; }
        public string JobQuestions { get; set; }
        public List<IFormFile> JobFiles { get; set; }
        public string presentjobfiles { get; set; }
    }
    public class ViewPostJobModel
    {
        public Guid? JobId { get; set; }
        public string ChJobID { get; set; }
        public string PostedByID { get; set; }
        public string RoleId { get; set; }
        public string JobDescription { get; set; }
        public List<string> Skills { get; set; }
        public List<string> JobQuestions { get; set; }
        public List<PostJobFiles> JobFiles { get; set; }

    }

    public class PostJobFiles
    {
        public string filetype { get; set;}
        public string fileurl { get; set; }
        public string filename { get; set; }
    }

    public class UpdateJobFiles
    {
        public string filetype { get; set; }
        public string fileurl { get; set; }
        public string Is_Delete { get; set; }
    }

}
