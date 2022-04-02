
$(document).ready(function () {
    LoadMasterData('adventure', '1', '3');
    LoadMasterData('language', '11', '3');
    $('#AddProfile').change(function () {

        if ($(this).val() === 'Work Experience') { $("#aboutModal").modal('show'); }
        else if ($(this).val() === 'Skills') { $("#AddSkillModal").modal('show'); $('.selectpicker').selectpicker();}
        else if ($(this).val() === 'Certifications') { $("#AddCertificationsModal").modal('show'); }
        else if ($(this).val() === 'Education') { $("#AddEducationModal").modal('show'); }
        else if ($(this).val() === 'Language') { $("#AddLanguageModal").modal('show');}
        LoadAllMasterData();
        LoadYear();
    })
    $('.btn-close,.back').click(function () {
        $('#AddProfile').prop('selectedIndex', 0);
    });

    $('#isCurrentCompany').click(function () {
        if ($("#isCurrentCompany").is(':checked')) {
            $(".EndDate").prop('disabled', true);
            $(".EndDate").val('');
            $(".EndDate").css('background-color','');

        } else {
            $(".EndDate").prop('disabled', false);
            $(".EndDate").css('background-color', '#FFFFFF');
        }
    });
    $('#isDesignation').click(function () {
        if ($("#isDesignation").is(':checked')) {
            $("#DesigEndDate").prop('disabled', true);
            $("#DesigEndDate").val('');
            $("#DesigEndDate").css('background-color', '');

        } else {
            $("#DesigEndDate").prop('disabled', false);
            $("#DesigEndDate").css('background-color', '#FFFFFF');
        }
    });
});

function LoadAllMasterData() {
    LoadMasterData('CompanyName', '7', '1');
    LoadMasterData('Designationtype', '8', '1');
    LoadMasterData('Employmenttype', '9', '1');
    LoadMasterData('degree', '4', '1');
    LoadMasterData('university', '5', '1');
    LoadMasterData('edulocation', '10', '1');
}

$(document).ready(function () {
    $(".datePicker").datepicker({
        format: "M-yyyy",
        viewMode: "months",
        minViewMode: "months",
        autoclose: true
    });
});

function LoadMasterData(controlid, masterId, is_options) {
     $("#" + controlid + "").html('');
    $.ajax({
        url: "../User/GetMasterData",
        type: "POST", 
        data: { masterId: masterId, is_options: is_options },
        async: false,
        success: function (data) {
            
            if (is_options == 1) {
                $("#" + controlid + "").append(data);
                if (controlid == 'CompanyName') {
                    $("#CertiReceived").html('');
                    $("#CertiReceived").append(data);
                }
            }
            if (is_options == 3) {
                $("#" + controlid + "").append(data);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function LoadYear() {
    var nowY = new Date().getFullYear(),
        options = "";

    for (var Y = nowY; Y >= 1980; Y--) {
        options += "<option>" + Y + "</option>";
    }

    $(".year").append(options);
}

function LoadModalWorkexp(id)
{
    $("#" + id + "").modal('show');
}

function SaveWorkExp()
{
    var formData = new FormData();
    debugger;
    var CompanyId = $("#CompanyName").val();
    formData.append("CompanyId", CompanyId);

    var CompanyName = $("#CompanyName option:selected").text();
    formData.append("CompanyName", CompanyName);

    var CompanyStartDate = $("#StartDate").val();
    formData.append("CompanyStartDate", CompanyStartDate);

    var CompanyEndDate = $("#EndDate").val();
    formData.append("CompanyEndDate", CompanyEndDate);

    var Is_currentCompany = "0";
    if ($("#isCurrentCompany").prop('checked') == true)
    {
        Is_currentCompany = "1";
    }
    formData.append("Is_currentCompany", Is_currentCompany);

    var DesignationId = $("#Designationtype").val();
    formData.append("DesignationId", DesignationId);

    var DesignationName = $("#Designationtype option:selected").text();
    formData.append("DesignationName", DesignationName);

    var DesignationStartDate = $("#DesigStartDate").val();
    formData.append("DesignationStartDate", DesignationStartDate);

    var DesignationEndDate = $("#DesigEndDate").val();
    formData.append("DesignationEndDate", DesignationEndDate);

   
    var JobProfile = $("#JobProfile").val();
    formData.append("JobProfile", JobProfile);

    var Is_currentDesignation = "0";
    if ($("#isDesignation").prop('checked') == true) {
        Is_currentDesignation = "1";
    }
    formData.append("Is_currentDesignation", Is_currentDesignation);

    var EmploymentType = $("#Employmenttype").val();
    formData.append("EmploymentType", EmploymentType);

    var EmploymentTypeName = $("#Employmenttype option:selected").text();
    formData.append("EmploymentTypeName", EmploymentTypeName);
    formData.append("Designatioexpid", $("#Designatioexpid").val());
    //
    $.ajax({
        url: "../Profile/AddUpdateWorkExp",
        type: "POST",
        data: formData, processData: false,
        contentType: false,
        async: false,
        success: function (data)
        {
            if (data == "1") {
                alert("Profile updated");
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function AddNewPostion(id,startdate,endate,is_current)
{
    LoadMasterData('CompanyName', '7', '1');
    LoadMasterData('Designationtype', '8', '1');
    LoadMasterData('Employmenttype', '9', '1');
    debugger;
    $("#CompanyName").val(id);
    $("#StartDate").val(startdate);
    $("#EndDate").val(endate);
    if (is_current == "1") {
        $("#isCurrentCompany").prop('checked', true);
    }
    $("#aboutModal").modal('show');
}

function EditPostions(id, startdate, endate, is_current, DesignationId, EmploymentType, JobProfile, Is_currentDesignation, DesigStartDate, DesigEndDate) {

    LoadMasterData('CompanyName', '7', '1');
    LoadMasterData('Designationtype', '8', '1');
    LoadMasterData('Employmenttype', '9', '1');
    $("#CompanyName").val(id);
    $("#StartDate").val(startdate);
    $("#EndDate").val(endate);
    if (is_current == "1") {
        $("#isCurrentCompany").prop('checked', true);
    }
    if (Is_currentDesignation == "1") {
        $("#isDesignation").prop('checked', true);
    }
    $("#Employmenttype").val(EmploymentType);
    $("#Designationtype").val(DesignationId);
    $("#DesigStartDate").val(DesigStartDate);
    $("#DesigEndDate").val(DesigEndDate);
    $("#JobProfile").val($("#" + id + "_" + DesignationId).text());
    $("#aboutModal").modal('show');

}

function AddCertifications()
{
    var formData = new FormData();
    debugger; 
    formData.append("certification", $("#Certification").val());
    formData.append("certificationid", $("#certificationid").val());
    formData.append("certiIDNo", $("#CertiIDNo").val());
    formData.append("certiReceived", $("#CertiReceived").val());
    formData.append("certiReceivedname", $("#CertiReceived option:selected").text());
    formData.append("certiValidTill", $("#CertiValidTill").val());
    formData.append("certiAttach", $("#CertiAttach").val());
    var input = document.getElementById('CertiAttachfile');
    var files = input.files;
    for (var i = 0; i != files.length; i++) {
        formData.append("Attachments", files[i]);
    }
    $.ajax({
        url: "../Profile/AddUpdateCertifications",
        type: "POST",
        data: formData, processData: false,
        contentType: false,
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function Editcertification(certificationid, certification, certiIDNo, certiValidTill, certiReceived, CertiAttach)
{
    LoadMasterData('CompanyName', '7', '1');
    $("#Certification").val(certification);
    $("#certificationid").val(certificationid);
    $("#CertiIDNo").val(certiIDNo);
    $("#CertiReceived").val(certiReceived);
    $("#CertiValidTill").val(certiValidTill);
    $("#CertiAttach").val(CertiAttach);
    $("#AddCertificationsModal").modal('show');
}

function SaveEducations()
{
    var formData = new FormData();
    formData.append("educationid", $("#educationid").val());
    formData.append("degree", $("#degree").val());
    formData.append("degreename", $("#degree option:selected").text());
    formData.append("university", $("#university").val());
    formData.append("universityname", $("#university option:selected").text());
    formData.append("edulocation", $("#edulocation").val());
    formData.append("edulocationname", $("#edulocation option:selected").text());
    formData.append("edustDate", $("#edustDate").val());
    formData.append("eduEndDate", $("#eduEndDate").val());
    $.ajax({
        url: "../Profile/AddUpdateEducation",
        type: "POST",
        data: formData, processData: false,
        contentType: false,
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });

}

function Editeducation(educationid, degree, university, edustDate, eduEndDate, edulocation) {
    LoadAllMasterData();
    $("#educationid").val(educationid);
    $("#degree").val(degree);
    $("#university").val(university);
    $("#edulocation").val(edulocation);
    $("#edustDate").val(edustDate);
    $("#eduEndDate").val(eduEndDate);
    $("#AddEducationModal").modal('show');
}

function AddSkill()
{
    debugger;
    var skills = $("#txt_Skills").val();
    $.ajax({
        url: "../Profile/InsertSkills",
        type: "POST",
        data: { skills: skills},
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function updateSkill(skill,count) {
    debugger;

    $.ajax({
        url: "../Profile/UpdateSkillSelfrating",
        type: "POST",
        data: { skill: skill, count: count },
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function Addlanguage() {
    var lang = $("#txt_language").val();
    var prof = $("#Proficiency option:selected").text();
    $.ajax({
        url: "../Profile/Insertlanguages",
        type: "POST",
        data: { langugae: lang, rating: prof },
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}

function Editaboutyou()
{
    $("#txt_about").val($("#about_section_txt").text().trim());
    $("#about_section").show();
    $("#about_section_txt").hide();
}

function saveaboutyou()
{
    $("#about_section_txt").text($("#txt_about").val());
    $("#about_section").hide();
    $("#about_section_txt").show();

    $.ajax({
        url: "../Profile/InsertAboutProfile",
        type: "POST",
        data: { message: $("#txt_about").val()},
        async: false,
        success: function (data) {
            if (data == "1") {
                location.reload(true);
            }
        },
        error: function (xhr, error, status) {
            console.log(error, status);
        }
    });
}