using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace Cohire.Models.Profile
{
    public class ProfileModel
    {
       public ProfileGeneraldetails profilegeneral { get; set; }
        public List<WorkExperience> WorkExperience { get; set; }
        public List<Certifications> certifications { get; set; }
        public List<Education> education { get; set; }
        public List<Profileskills> skills { get; set; }
        public List<Language> languages { get; set; }
        public string AboutProfile { get; set; }
    }
    public class ProfileModelList
    {
        public List<WorkExperienceList> WorkExperience { get; set; }
        public List<Certifications> certifications { get; set; }
        public List<Education> education { get; set; }
        public List<Profileskills> skills { get; set; }
        public List<Language> languages { get; set; }
        public string AboutProfile { get; set; }
    }
    public class WorkExperienceRequest
    {
        public int CompanyId { get; set; }
        public string CompanyName { get; set; }
        public string CompanyStartDate { get; set; }
        public string CompanyEndDate { get; set; }
        public int Is_currentCompany { get; set; }
        public int EmploymentType { get; set; }
        public string EmploymentTypeName { get; set; }
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

    #region--------------Certifications--------------------
    public class Certifications
    {
        public string certificationid { get; set; }
        public string certification { get; set; }
        public string certiIDNo { get; set; }
        public string certiReceived { get; set; }
        public string certiReceivedname { get; set; }
        public DateTime? certiValidTill { get; set; }
        public string certiAttach { get; set; }
    }
    #endregion
    #region-------- Education--------------------
    public class Education
    {
        public string educationid { get; set; }
        public string degree { get; set; }
        public string degreename { get; set; }
        public string university { get; set; }
        public string universityname { get; set; }
        public string edulocation { get; set; }
        public string edulocationname { get; set; }
        public DateTime? edustDate { get; set; }
        public DateTime? eduEndDate { get; set; }
    }
    #endregion

    #region------Skills-----------
    public class Profileskills
    {
        public string id { get; set; }
        public string skill { get; set; }
        public string selfrating { get; set; }
    }

    public class Language
    {
        public string language { get; set; }
        public string selfrating { get; set; }
    }
    #endregion


    public class ProfileGeneraldetails
    {
        public string profileid { get; set; }
        public string name { get; set; }
        public string email { get; set; }
        public string mobilenumber { get; set; }
        public string profilebio { get; set; }
        public string profileabout { get; set; }
        public string image { get; set; }
    }
}