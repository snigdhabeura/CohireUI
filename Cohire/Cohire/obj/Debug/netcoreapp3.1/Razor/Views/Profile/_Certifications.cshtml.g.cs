#pragma checksum "C:\Users\Admin\Pictures\New folder\CohireUI\Cohire\Cohire\Views\Profile\_Certifications.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "58747bb78f71727376cea06f32ec6e380e29b9d2"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Profile__Certifications), @"mvc.1.0.view", @"/Views/Profile/_Certifications.cshtml")]
namespace AspNetCore
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.AspNetCore.Mvc.Rendering;
    using Microsoft.AspNetCore.Mvc.ViewFeatures;
#nullable restore
#line 1 "C:\Users\Admin\Pictures\New folder\CohireUI\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\Admin\Pictures\New folder\CohireUI\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"58747bb78f71727376cea06f32ec6e380e29b9d2", @"/Views/Profile/_Certifications.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"6ea59a34af991f172abef7c894b4ab93a398505a", @"/Views/_ViewImports.cshtml")]
    public class Views_Profile__Certifications : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<dynamic>
    {
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"<div class=""modal fade"" id=""AddCertificationsModal"" data-bs-backdrop=""static"" data-bs-keyboard=""false"" tabindex=""-1"" aria-labelledby=""staticBackdropLabel"" aria-hidden=""true"">
    <div class=""modal-dialog modal-dialog-centered modal-lg"">
        <div class=""modal-content rounded-4 p-4 border-0 bg-light"">
            <div class=""modal-header d-flex align-items-center justify-content-start border-0 p-0 mb-2"">
                <a href=""#"" class=""text-muted text-decoration-none material-icons back"" data-bs-dismiss=""modal"">arrow_back_ios_new</a>
                <h5 class=""modal-title text-muted ms-3 ln-0"" id=""staticBackdropLabel""><span class=""material-icons md-32"">account_circle</span></h5>
                <h5 class=""modal-title text-muted ms-3 ln-0""><span class=""md-10"">Add Certifications</span></h5>
                <button type=""button"" class=""btn-close"" data-bs-dismiss=""modal"" aria-label=""Close"" style=""padding-top:1%;""></button>
            </div>
            <div id=""divAddCertifications"" class=""collapse");
            WriteLiteral(@" show"">
                <div class=""row g-2 mb-1"">
                    <div class=""col-md"">
                        <div class=""form-floating"">
                            <input type=""hidden"" id=""certificationid"" />
                          <input type=""text""  class=""form-control  rounded-5 input-append"" id=""Certification"" style=""background-color: #FFFFFF"">
                            <label for=""Certification"">Certification</label>
                        </div>
                    </div>
                </div>
                <div class=""row g-2 mb-1"">
                    <div class=""col-md"">
                        <div class=""form-floating"">
                                                    <input type=""text""  class=""form-control  rounded-5 input-append"" id=""CertiIDNo"" style=""background-color: #FFFFFF"">

                            <label for=""CertiIDNo"">ID No</label>
                        </div>
                    </div>
                    <div class=""col-md"">
                 ");
            WriteLiteral(@"       <div class=""form-floating"">
                            <select class=""form-select  rounded-5"" id=""CertiReceived"" data-live-search=""true"" aria-label=""Floating label select example"">
                            </select>
                            <label for=""CertiReceived"">Received</label>
                        </div>
                    </div>
                </div>
                 <div class=""row g-2 mb-1"">
                    <div class=""col-md"">
                        <div class=""form-floating"">
                          <input type=""text"" readonly=""readonly"" name=""date"" class=""form-control  rounded-5 input-append date datePicker"" id=""CertiValidTill"" style=""cursor:pointer; background-color: #FFFFFF"">
                            <label for=""CertiValidTill"">Valid Till</label>
                        </div>
                    </div>
                    <div class=""col-md"">
                        <div class=""form-floating"">
                        <input type=""text""  class=""form-");
            WriteLiteral(@"control  rounded-5 input-append"" id=""CertiAttach"" style=""background-color: #FFFFFF"">
                        <label for=""CertiAttach"">URL</label>
                        </div>
                    </div>
                </div>

                <div class=""modal-footer px-1 py-1 rounded-5"">
                    <div class=""ms-auto m-0"">
                        <button  class=""btn btn-primary rounded-5 fw-bold px-3 py-2 fs-6 mb-0 d-flex align-items-center"" href=""javascript:void(0)"" onclick=""AddCertifications()""><span class=""material-icons me-2md-16"">send</span>Save</button>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


");
        }
        #pragma warning restore 1998
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.ViewFeatures.IModelExpressionProvider ModelExpressionProvider { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IUrlHelper Url { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.IViewComponentHelper Component { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IJsonHelper Json { get; private set; }
        [global::Microsoft.AspNetCore.Mvc.Razor.Internal.RazorInjectAttribute]
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<dynamic> Html { get; private set; }
    }
}
#pragma warning restore 1591