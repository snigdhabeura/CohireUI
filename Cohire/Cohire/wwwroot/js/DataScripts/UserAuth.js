function cancelmodal() {
    var r = confirm("Are you sure?");
    if (r == true) {
        location.reload();
    }
};
function ViewSignUp() {
    $("#forget_Password").hide();
    $("#signin_body").hide();
    $("#modal_loader").hide();
    $("#signup_body").show();
}
function ViewSignin() {
    $("#forget_Password").hide();
    $("#modal_loader").hide();
    $("#signup_body").hide();
    $("#signin_body").show();

}
function viewforgetpassword() {
    $("#signin_body").hide();
    $("#signup_body").hide();
    $("#modal_loader").hide();
    $("#forget_Password").show();
}
function VerifySignUp() {
    debugger;
    $("#signup_body").hide();
    $("#modal_loader").show();
    var Is_error = 0;
    if ($("#pxp-signup-FullName").val() == '') {
        $("#pxp-signup-FullName_err").addClass('errClass');
        $("#pxp-signup-FullName_err").html("Full name required"); Is_error = 1; $("#signup_body").show();
        $("#modal_loader").hide();
    }
    if ($("#pxp-signup-email").val() == '') {
        $("#pxp-signup-email_err").addClass('errClass');
        $("#pxp-signup-email_err").html("Email/Mobile number required"); Is_error = 1; $("#signup_body").show();
        $("#modal_loader").hide();
    } else {
        var Is_email = validateEmail($("#pxp-signup-email").val());
        var Is_mobile = validatePhone($("#pxp-signup-email").val());
        if (Is_email == false && Is_mobile == false) {
            $("#pxp-signup-email_err").addClass('errClass');
            $("#pxp-signup-email_err").html("Please enter a valid Email/Mobile number"); Is_error = 1; $("#signup_body").show();
            $("#modal_loader").hide();
        }
    }
    if ($("#pxp-signup-password").val() == '') {
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html("Password required"); Is_error = 1; $("#signup_body").show();
        $("#modal_loader").hide();
    } else {
        var Is_PasswordValid = validatePassword($("#pxp-signup-password").val());
        if (Is_PasswordValid != true) {
            Is_error = 1;
        }
    }

    if (Is_error == 0) {
        var FullName = $("#pxp-signup-FullName").val();
        var Email = '';
        var Mobile = '';
        var Password = $("#pxp-signup-password").val();
        if (Is_email == true) {
            $("#otp_confirm").html("Otp has been send to your email");
            Email = $("#pxp-signup-email").val();
        }
        if (Is_mobile == true) {
            $("#otp_confirm").html("Otp has been send to your mobile number");
            Mobile = $("#pxp-signup-email").val();
        }
        var Ip_Address = '';
        var Is_Mobile = '';
        //$.get("https://ipinfo.io?token=c74e2bd432e4f1", function (response) {
        //    debugger;
        //    Ip_Address = response.ip;
        //}, "json");
        if (window.matchMedia("(max-width: 767px)").matches) {
            Is_Mobile = "Mobile";
        } else {
            Is_Mobile = "PC";
        }
        $.ajax({
            type: 'POST',
            url: "/Authentication/SignUp",
            data: { FullName: FullName, Email: Email, Mobile: Mobile, Password: Password, Ip_Address: Ip_Address, DeviceType: Is_Mobile },
            dataType: "json",
            success: function (resultData) {
                debugger;
                if (resultData.is_error == true) {
                    $("#SignUp_err_msg").addClass('errClass');
                    $("#SignUp_err_msg").html(resultData.errormsg); $("#modal_loader").hide(); $("#signup_body").show();

                } else {
                    $("#hdn_profileId").val(resultData.profileID);
                    $("#signin_body").hide();
                    $("#signup_body").hide();
                    $("#signup_OTP").show();
                    $("#SignUpOTP").addClass('sucClass');
                    $("#SignUpOTP").html(resultData.errormsg); $("#modal_loader").hide();

                }
            }
        });
    }
}
function RemoveErrorMesage(id) {
    if ($("#" + id + "").val() != '') {
        $("#" + id + "_err").html("");
    }
}

function validateEmail(email) {
    var emailRegex = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return emailRegex.test(email);
}

function validatePhone(phone) {
    //Validates the phone number
    var phoneRegex = /^(\+91-|\+91|0)?\d{10}$/; // Change this regex based on requirement
    return phoneRegex.test(phone);
}

function VerifyOTP() {
    $("#signup_OTP").hide();
    $("#modal_loader").show();
    $("#SignUpOTP").html('');
    $("#pxp-signup-otp_err").html('');
    if ($("#pxp-signup-otp").val() == '') {
        $("#pxp-signup-otp_err").addClass('errClass');
        $("#pxp-signup-otp_err").html('Please enter OTP');
        $("#signup_OTP").show();
        $("#modal_loader").hide();
        return false;
    }
    $.ajax({
        type: 'POST',
        url: "/Authentication/VerifyOTP",
        data: { CHProfileID: $("#hdn_profileId").val(), OTP: $("#pxp-signup-otp").val() },
        dataType: "json",
        success: function (resultData) {
            debugger;
            if (resultData.is_error == true) {
                $("#SignUpOTP").removeClass("sucClass");
                $("#SignUpOTP").addClass("errClass");
                $("#SignUpOTP").html(resultData.errormsg);
                $("#signup_OTP").show();
                $("#modal_loader").hide();
            } else {
                $("#SignUpOTP").removeClass("errClass");
                $("#SignUpOTP").addClass("sucClass")
                $("#SignUpOTP").html(resultData.errormsg);
                $("#signup_OTP").show();
                $("#modal_loader").hide();
                location.reload(true);
            }
        }
    });
}
function ResendOTP() {
    $("#signup_OTP").hide();
    $("#modal_loader").show();
    var Email = '';
    var Mobile = '';
    var Is_email = validateEmail($("#pxp-signup-email").val());
    var Is_mobile = validatePhone($("#pxp-signup-email").val());
    if (Is_email == true) {
        $("#SignUpOTP").html("");
        Email = $("#pxp-signup-email").val();
    }
    if (Is_mobile == true) {
        $("#SignUpOTP").html("");
        Mobile = $("#pxp-signup-email").val();
    }
    $(".SignUpOTP").html("");
    $.ajax({
        type: 'POST',
        url: "/Authentication/ResenOTP",
        data: { Email: Email, Mobile: Mobile, CHProfileID: $("#hdn_profileId").val() },
        dataType: "json",
        success: function (resultData) {
            debugger;
            if (resultData.is_error == true) {
                $("#SignUpOTP").addClass('errClass');
                $("#SignUpOTP").html(resultData.errormsg); $("#signup_OTP").show();
                $("#modal_loader").hide();
            } else {
                if (Is_email == true) {
                    $("#SignUpOTP").addClass('sucClass');
                    $("#SignUpOTP").html("Otp has been sent to your email"); $("#signup_OTP").show();
                    $("#modal_loader").hide();
                }
                if (Is_mobile == true) {
                    $("#SignUpOTP").addClass('sucClass');
                    $("#SignUpOTP").html("Otp has been sent to your mobile number"); $("#signup_OTP").show();
                    $("#modal_loader").hide();
                }
            }
        }
    });
}

function SendPassword() {
    debugger;
    $("#forget_Password").hide();
    $("#modal_loader").show();
    var Is_email = validateEmail($("#pxp-forgot-email").val());
    var Is_mobile = validatePhone($("#pxp-forgot-email").val());
    var Email = '';
    var Mobile = '';
    if ($("#pxp-forgot-email").val() != '') {
        if (Is_email == true) {
            Email = $("#pxp-forgot-email").val();
        }
        if (Is_mobile == true) {
            Mobile = $("#pxp-forgot-email").val();
        }
        $.ajax({
            type: 'POST',
            url: "/Authentication/SendPassword",
            data: { Email: Email, Mobile: Mobile },
            dataType: "json",
            success: function (resultData) {
                debugger;
                if (resultData.is_error == true) {
                    $("#forgot-email").removeClass("sucClass");
                    $("#forgot-email").addClass("errClass");
                    $("#forgot-email").html(resultData.errormsg);
                    $("#modal_loader").hide();
                    $("#forget_Password").show();
                }
                else {
                    $("#forgot-email").removeClass("errClass");
                    $("#forgot-email").addClass("sucClass");
                    $("#forgot-email").html(resultData.errormsg);
                    $("#modal_loader").hide();
                    $("#forget_Password").show();
                }
            }
        });
    }
    else {
        $("#pxp-forgot-email_err").addClass('errClass');
        $("#pxp-forgot-email_err").html('Email/Mobile required');
        $("#forget_Password").show();
        $("#modal_loader").hide();
    }
}

function VerifySignIn() {
    debugger;
    var Is_error = 0;
    if ($("#pxp-signin-email").val() == '') {
        $("#pxp-signin-email_err").addClass("errClass");
        $("#pxp-signin-email_err").html("Please enter Email/Mobile number"); Is_error = 1;
    }
    if ($("#pxp-signin-password").val() == '') {
        $("#pxp-signin-password_err").addClass("errClass");
        $("#pxp-signin-password_err").html("Please enter Password"); Is_error = 1;
    } var Is_email = validateEmail($("#pxp-signin-email").val());
    var Is_mobile = validatePhone($("#pxp-signin-email").val());
    if (Is_email == false && Is_mobile == false) {
        $("#pxp-signin-email_err").addClass("errClass");
        $("#pxp-signin-email_err").html("Please enter valid Email/Mobile number"); Is_error = 1;
    }
    if (Is_error == 0) {
        
        var Email = '';
        var Mobile = '';
        var Password = $("#pxp-signin-password").val();
        if (Is_email == true) {
            Email = $("#pxp-signin-email").val();
        }
        if (Is_mobile == true) {
            Mobile = $("#pxp-signin-email").val();
        }
        var Ip_Address = '';
        var Is_Mobile = '';
        //$.get("https://ipinfo.io", function (response) {
        //    Ip_Address = response.ip;
        //}, "json");
        if (window.matchMedia("(max-width: 767px)").matches) {
            Is_Mobile = "Mobile";
        } else {
            Is_Mobile = "PC";
        }
        $.ajax({
            type: 'POST',
            url: "/Authentication/SignIn",
            data: { Email: Email, Mobile: Mobile, Password: Password, Ip_Address: Ip_Address, DeviceType: Is_Mobile },
            dataType: "json",
            success: function (resultData) {
                debugger;
                if (resultData != '0') {
                    location.reload(true);
                } else {
                    alert("Invalid Email/mobile number or Password.");
                }
            }
        });
    }
}


/////////Region Password Validations


function checklower(value) {
    return /[a-z]/.test(value);
};
function checkupper (value) {
    return /[A-Z]/.test(value);
};
function checkdigit(value) {
    return /[0-9]/.test(value);
};


function validatePassword()
{
    debugger;
    var password = $("#pxp-signup-password").val();
    var Is_PasswordValid = true;

    
    $("#pxp-signup-password_err").html('');
    if (checklower(password) != true) {
        Is_PasswordValid = false;
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html('Need atleast 1 lowercase alphabet'); return Is_PasswordValid;
    }
    else if (checkupper(password) != true) {
        Is_PasswordValid = false;
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html('Need atleast 1 uppercase alphabet'); return Is_PasswordValid;
    }
    else if (checkdigit(password) != true) {
        Is_PasswordValid = false;
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html('Need atleast 1 digit'); return Is_PasswordValid;
    }
    else if (password.length > 10) {
        Is_PasswordValid = false;
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html('Maximum password length is 10'); return Is_PasswordValid;
    }
    else if (password.length < 6) {
        Is_PasswordValid = false;
        $("#pxp-signup-password_err").addClass('errClass');
        $("#pxp-signup-password_err").html('Minimum password length is 6'); return Is_PasswordValid;
    }
    else {
        return Is_PasswordValid;
    }

}
////////////////////