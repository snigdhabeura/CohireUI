using System;
using System.Collections.Generic;

namespace Cohire.Models.Profile
{
    public class ProfileModel
    {
       public List<WorkExperience> WorkExperience { get; set; }
    }
    public class ProfileModelList
    {
        public List<WorkExperience> WorkExperience { get; set; }
    }
    public class WorkExperienceRequest
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string CompanyStartDate { get; set; }
        public string CompanyEndDate { get; set; }
        public int Is_currentCompany { get; set; }
        public int EmploymentType { get; set; }
        public string EmploymentTypeName{ get; set; }
        public int DesignationId { get; set; }
        public string DesignationName { get; set; }
        public string DesignationStartDate { get; set; }
        public string DesignationEndDate { get; set; }
        public int Is_currentDesignation { get; set; }
        public string JobProfile { get; set; }
    }

    public class Designatioexp
    {
        public int DesignationId { get; set; }
        public string DesignationName { get; set; }
        public string DesignationStartDate { get; set; }
        public string DesignationEndDate { get; set; }
        public int Is_currentDesignation { get; set; }
        public string JobProfile { get; set; }
        public int EmploymentType { get; set; }
        public string EmploymentTypeName { get; set; }
    }

    public class WorkExperience
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string CompanyStartDate { get; set; }
        public object CompanyEndDate { get; set; }
        public int Is_currentCompany { get; set; }
       
        public List<Designatioexp> designatioexp { get; set; }
    }



    public class DesignatioexpList
    {
        public int DesignationId { get; set; }
        public string DesignationName { get; set; }
        public DateTime? DesignationStartDate { get; set; }
        public DateTime? DesignationEndDate { get; set; }
        public int Is_currentDesignation { get; set; }
        public string JobProfile { get; set; }
        public int EmploymentType { get; set; }
        public string EmploymentTypeName { get; set; }
    }

    public class WorkExperienceList
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public DateTime? CompanyStartDate { get; set; }
        public DateTime? CompanyEndDate { get; set; }
        public int Is_currentCompany { get; set; }

        public List<DesignatioexpList> designatioexp { get; set; }
    }
}
