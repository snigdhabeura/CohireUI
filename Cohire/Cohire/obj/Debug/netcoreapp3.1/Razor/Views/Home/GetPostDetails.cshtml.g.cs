#pragma checksum "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "d9008f3ccc7e75bb94e767f1fe89e87637a9f602"
// <auto-generated/>
#pragma warning disable 1591
[assembly: global::Microsoft.AspNetCore.Razor.Hosting.RazorCompiledItemAttribute(typeof(AspNetCore.Views_Home_GetPostDetails), @"mvc.1.0.view", @"/Views/Home/GetPostDetails.cshtml")]
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
#line 1 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\_ViewImports.cshtml"
using Cohire.Models;

#line default
#line hidden
#nullable disable
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"d9008f3ccc7e75bb94e767f1fe89e87637a9f602", @"/Views/Home/GetPostDetails.cshtml")]
    [global::Microsoft.AspNetCore.Razor.Hosting.RazorSourceChecksumAttribute(@"SHA1", @"6ea59a34af991f172abef7c894b4ab93a398505a", @"/Views/_ViewImports.cshtml")]
    public class Views_Home_GetPostDetails : global::Microsoft.AspNetCore.Mvc.Razor.RazorPage<Cohire.Models.JobFeedListNM.JobActionModel>
    {
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_0 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("src", new global::Microsoft.AspNetCore.Html.HtmlString("~/Img/rmate4.jpg"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_1 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("class", new global::Microsoft.AspNetCore.Html.HtmlString("img-fluid rounded-circle user-img"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        private static readonly global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute __tagHelperAttribute_2 = new global::Microsoft.AspNetCore.Razor.TagHelpers.TagHelperAttribute("alt", new global::Microsoft.AspNetCore.Html.HtmlString("profile-img"), global::Microsoft.AspNetCore.Razor.TagHelpers.HtmlAttributeValueStyle.DoubleQuotes);
        #line hidden
        #pragma warning disable 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperExecutionContext __tagHelperExecutionContext;
        #pragma warning restore 0649
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner __tagHelperRunner = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperRunner();
        #pragma warning disable 0169
        private string __tagHelperStringValueBuffer;
        #pragma warning restore 0169
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __backed__tagHelperScopeManager = null;
        private global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager __tagHelperScopeManager
        {
            get
            {
                if (__backed__tagHelperScopeManager == null)
                {
                    __backed__tagHelperScopeManager = new global::Microsoft.AspNetCore.Razor.Runtime.TagHelpers.TagHelperScopeManager(StartTagHelperWritingScope, EndTagHelperWritingScope);
                }
                return __backed__tagHelperScopeManager;
            }
        }
        private global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper;
        #pragma warning disable 1998
        public async override global::System.Threading.Tasks.Task ExecuteAsync()
        {
            WriteLiteral(@"   
    <div class=""modal-dialog modal-dialog-centered"">
        <div class=""modal-content rounded-4 overflow-hidden border-0"">
            <div class=""modal-header d-none"">
                <h5 class=""modal-title"" id=""exampleModalLabel2"">Modal title</h5>
                <button type=""button"" class=""btn-close"" data-bs-dismiss=""modal"" aria-label=""Close""></button>
            </div>
            <div class=""modal-body p-0"">
                <div class=""row m-0"">
                    <div class=""col-sm-7 px-0 m-sm-none"">
");
#nullable restore
#line 12 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                         if (Model.jobFeedList.JobFiles.Count > 0)
                        {

#line default
#line hidden
#nullable disable
            WriteLiteral("                            <div class=\"image-slider\">\r\n                                <div");
            BeginWriteAttribute("id", " id=\"", 769, "\"", 830, 2);
            WriteAttributeValue("", 774, "carouselExampleIndicatorspops_", 774, 30, true);
#nullable restore
#line 15 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 804, Model.jobFeedList.ChJobID, 804, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"carousel slide\" data-bs-ride=\"carousel\">\r\n                                    <div class=\"carousel-indicators\">\r\n");
#nullable restore
#line 17 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                           int i = 0;

#line default
#line hidden
#nullable disable
#nullable restore
#line 18 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                         foreach (var v in Model.jobFeedList.JobFiles.ToList().Where(x => x.filetype.ToLower() == "png" || x.filetype.ToLower() == "jpg" || x.filetype.ToLower() == "jpeg" || x.filetype.ToLower() == "gif" || x.filetype.ToLower() == "mp4"))
                                        {

                                            int slied = i + 1;

#line default
#line hidden
#nullable disable
            WriteLiteral("                                            <button type=\"button\" data-bs-target=\"#carouselExampleIndicatorspops_");
#nullable restore
#line 22 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                            Write(Model.jobFeedList.ChJobID);

#line default
#line hidden
#nullable disable
            WriteLiteral("\" data-bs-slide-to=\"");
#nullable restore
#line 22 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                          Write(i);

#line default
#line hidden
#nullable disable
            WriteLiteral("\" class=\"active\"");
            BeginWriteAttribute("aria-label", " aria-label=\"", 1566, "\"", 1591, 2);
            WriteAttributeValue("", 1579, "Slide", 1579, 5, true);
#nullable restore
#line 22 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue(" ", 1584, slied, 1585, 6, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" aria-current=\"true\"></button>\r\n");
#nullable restore
#line 23 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                            i++;
                                        }

#line default
#line hidden
#nullable disable
            WriteLiteral("\r\n                                    </div>\r\n\r\n                                    <div class=\"carousel-inner\">\r\n");
#nullable restore
#line 29 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                           i = 0;

#line default
#line hidden
#nullable disable
#nullable restore
#line 30 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                         foreach (var v in Model.jobFeedList.JobFiles.Where(x => x.filetype.ToLower() == "png" || x.filetype.ToLower() == "jpg" || x.filetype.ToLower() == "jpeg" || x.filetype.ToLower() == "gif" || x.filetype.ToLower() == "mp4").ToList())
                                        {
                                            if (v.filetype.ToLower() != "mp4")
                                            {
                                                if (i == 0)
                                                {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                    <div class=\"carousel-item active\">\r\n                                                        <img");
            BeginWriteAttribute("src", " src=\"", 2585, "\"", 2601, 1);
#nullable restore
#line 37 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 2591, v.fileurl, 2591, 10, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"d-block w-100\" alt=\"...\">\r\n                                                    </div> ");
#nullable restore
#line 38 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                           }
                                                else
                                                {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                    <div class=\"carousel-item\">\r\n                                                        <img");
            BeginWriteAttribute("src", " src=\"", 2945, "\"", 2961, 1);
#nullable restore
#line 42 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 2951, v.fileurl, 2951, 10, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"d-block w-100\" alt=\"...\">\r\n                                                    </div>\r\n");
#nullable restore
#line 44 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                }
                                                i++;
                                            }
                                            else if (v.filetype.ToLower() == "mp4")
                                            {
                                                if (i == 0)
                                                {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                    <div class=\"carousel-item active\">\r\n                                                        <video");
            BeginWriteAttribute("src", " src=\"", 3603, "\"", 3619, 1);
#nullable restore
#line 52 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 3609, v.fileurl, 3609, 10, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" controls />\r\n                                                    </div> ");
#nullable restore
#line 53 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                           }
                                                else
                                                {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                    <div class=\"carousel-item\">\r\n                                                        <video");
            BeginWriteAttribute("src", " src=\"", 3944, "\"", 3960, 1);
#nullable restore
#line 57 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 3950, v.fileurl, 3950, 10, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" controls />\r\n                                                    </div>\r\n");
#nullable restore
#line 59 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                }
                                                i++;
                                            }
                                        }

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                                    </div>
                                    <div>
                                        <button class=""carousel-control-prev"" type=""button"">
                                            <span class=""carousel-control-prev-icon"" aria-hidden=""true"" data-bs-target=""#carouselExampleIndicatorspops_");
#nullable restore
#line 66 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                  Write(Model.jobFeedList.ChJobID);

#line default
#line hidden
#nullable disable
            WriteLiteral(@""" data-bs-slide=""prev""></span>
                                            <span class=""visually-hidden"">Previous</span>
                                        </button>
                                        <button class=""carousel-control-next"" type=""button"">
                                            <span class=""carousel-control-next-icon"" aria-hidden=""true"" data-bs-target=""#carouselExampleIndicatorspops_");
#nullable restore
#line 70 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                  Write(Model.jobFeedList.ChJobID);

#line default
#line hidden
#nullable disable
            WriteLiteral(@""" data-bs-slide=""next""></span>
                                            <span class=""visually-hidden"">Next</span>
                                        </button>
                                    </div>

                                </div>
                            </div>
");
#nullable restore
#line 77 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                        }

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                    </div>
                    <div class=""col-sm-5 content-body px-web-0"">
                        <div class=""d-flex flex-column h-600"">
                            <div class=""d-flex p-3 border-bottom"">
                                ");
            __tagHelperExecutionContext = __tagHelperScopeManager.Begin("img", global::Microsoft.AspNetCore.Razor.TagHelpers.TagMode.StartTagOnly, "d9008f3ccc7e75bb94e767f1fe89e87637a9f60215773", async() => {
            }
            );
            __Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper = CreateTagHelper<global::Microsoft.AspNetCore.Mvc.Razor.TagHelpers.UrlResolutionTagHelper>();
            __tagHelperExecutionContext.Add(__Microsoft_AspNetCore_Mvc_Razor_TagHelpers_UrlResolutionTagHelper);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_0);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_1);
            __tagHelperExecutionContext.AddHtmlAttribute(__tagHelperAttribute_2);
            await __tagHelperRunner.RunAsync(__tagHelperExecutionContext);
            if (!__tagHelperExecutionContext.Output.IsContentModified)
            {
                await __tagHelperExecutionContext.SetOutputContentAsync();
            }
            Write(__tagHelperExecutionContext.Output);
            __tagHelperExecutionContext = __tagHelperScopeManager.End();
            WriteLiteral(@"
                                <div class=""d-flex align-items-center justify-content-between w-100"">
                                    <a href=""javascript:void(0)"" class=""text-decoration-none ms-3"">
                                        <div class=""d-flex align-items-center"">
                                            <h6 class=""fw-bold text-body mb-0"">");
#nullable restore
#line 86 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                          Write(Model.jobFeedList.PostedByName);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"</h6>
                                            <p class=""ms-2 material-icons bg-primary p-0 md-16 fw-bold text-white rounded-circle ov-icon mb-0"">done</p>
                                        </div>
                                        
                                        <p class=""text-muted mb-0 small"">POSTID:<b style=""color:black""> ");
#nullable restore
#line 90 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                   Write(Model.jobFeedList.ChJobID);

#line default
#line hidden
#nullable disable
            WriteLiteral("</b>  </p>\r\n                                        <p>\r\n");
#nullable restore
#line 92 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                             if (Model.jobFeedList.JobFiles.Where(x => x.filetype.ToLower() == "pdf" || x.filetype.ToLower() == "docx").ToList().Count > 0)
                                            {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                <span style=\"color:black;font-weight:bold\">  Attached Document:</span>\r\n");
#nullable restore
#line 95 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                 for (int i = 0; i < Model.jobFeedList.JobFiles.Count(); i++)
                                                {
                                                    if (Model.jobFeedList.JobFiles[i].filetype.ToLower() == "pdf")
                                                    {

#line default
#line hidden
#nullable disable
            WriteLiteral("                                                        <i");
            BeginWriteAttribute("onclick", " onclick=\"", 7263, "\"", 7328, 3);
            WriteAttributeValue("", 7273, "ViewDocument(\'", 7273, 14, true);
#nullable restore
#line 99 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 7287, Model.jobFeedList.JobFiles[i].filename, 7287, 39, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 7326, "\')", 7326, 2, true);
            EndWriteAttribute();
            BeginWriteAttribute("title", " title=\"", 7329, "\"", 7376, 1);
#nullable restore
#line 99 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 7337, Model.jobFeedList.JobFiles[i].filename, 7337, 39, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"fa fa-file-pdf-o\" aria-hidden=\"true\" style=\"color:palevioletred\"></i>\r\n");
#nullable restore
#line 100 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                    }
                                                    if (Model.jobFeedList.JobFiles[i].filetype.ToLower() == "docx")
                                                    {


#line default
#line hidden
#nullable disable
            WriteLiteral("                                                        <i");
            BeginWriteAttribute("onclick", " onclick=\"", 7743, "\"", 7808, 3);
            WriteAttributeValue("", 7753, "ViewDocument(\'", 7753, 14, true);
#nullable restore
#line 104 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 7767, Model.jobFeedList.JobFiles[i].filename, 7767, 39, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 7806, "\')", 7806, 2, true);
            EndWriteAttribute();
            BeginWriteAttribute("title", " title=\"", 7809, "\"", 7856, 1);
#nullable restore
#line 104 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 7817, Model.jobFeedList.JobFiles[i].filename, 7817, 39, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(" class=\"fa fa-file-word-o\" aria-hidden=\"true\" style=\"color:blue\"></i>\r\n");
#nullable restore
#line 105 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"

                                                    }
                                                }

#line default
#line hidden
#nullable disable
#nullable restore
#line 107 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                 
                                            }

#line default
#line hidden
#nullable disable
            WriteLiteral(@"                                        </p>
                                    </a>
                                    <div class=""small dropdown"">
                                        <a href=""#"" class=""text-muted text-decoration-none material-icons ms-2 md-"" data-bs-dismiss=""modal"">close</a>
                                    </div>
                                </div>
                            </div>
                            <div class=""comments p-3"" id=""cmt_popup"">

                            </div>
                            <div class=""border-top p-3 mt-auto"">
                                <div class=""d-flex align-items-center justify-content-between mb-2"">
                                    <div>
                                        <a title=""Apply"" href=""#"" class=""text-muted text-decoration-none d-flex align-items-start fw-light""><span class=""material-icons md-20 me-2"">work</span><span");
            BeginWriteAttribute("class", " class=\"", 9024, "\"", 9070, 2);
            WriteAttributeValue("", 9032, "apply_count_", 9032, 12, true);
#nullable restore
#line 122 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9044, Model.jobFeedList.ChJobID, 9044, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 122 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                                                                                                               Write(Model.jobFeedList.applyCount);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"</span></a>
                                    </div>
                                    <div>
                                        <a title=""Refer"" href=""javascript:void(0)"" class=""text-muted text-decoration-none d-flex align-items-start fw-light""");
            BeginWriteAttribute("onclick", " onclick=\"", 9357, "\"", 9410, 3);
            WriteAttributeValue("", 9367, "GetReferModel(\'", 9367, 15, true);
#nullable restore
#line 125 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9382, Model.jobFeedList.ChJobID, 9382, 26, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 9408, "\')", 9408, 2, true);
            EndWriteAttribute();
            WriteLiteral("><span class=\"material-icons md-20 me-2\">swap_horiz</span><span");
            BeginWriteAttribute("class", " class=\"", 9474, "\"", 9520, 2);
            WriteAttributeValue("", 9482, "refer_count_", 9482, 12, true);
#nullable restore
#line 125 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9494, Model.jobFeedList.ChJobID, 9494, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 125 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                                                                                                                                                                                            Write(Model.jobFeedList.referCount);

#line default
#line hidden
#nullable disable
            WriteLiteral("</span></a>\r\n                                    </div>\r\n                                    <div>\r\n                                        <a href=\"javascript:void(0)\" class=\"text-muted text-decoration-none d-flex align-items-start fw-light\"");
            BeginWriteAttribute("onclick", " onclick=\"", 9793, "\"", 9845, 3);
            WriteAttributeValue("", 9803, "IncreaseLike(\'", 9803, 14, true);
#nullable restore
#line 128 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9817, Model.jobFeedList.ChJobID, 9817, 26, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 9843, "\')", 9843, 2, true);
            EndWriteAttribute();
            WriteLiteral("><span class=\"material-icons md-20 me-2\"");
            BeginWriteAttribute("id", " id=\"", 9886, "\"", 9926, 2);
            WriteAttributeValue("", 9891, "likebtns_", 9891, 9, true);
#nullable restore
#line 128 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9900, Model.jobFeedList.ChJobID, 9900, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">thumb_up_off_alt</span><span");
            BeginWriteAttribute("class", " class=\"", 9956, "\"", 10000, 2);
            WriteAttributeValue("", 9964, "likeCount_", 9964, 10, true);
#nullable restore
#line 128 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 9974, Model.jobFeedList.ChJobID, 9974, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 128 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                                                                                                                                                                                                                          Write(Model.jobFeedList.likeCount);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"</span></a>
                                    </div>
                                    <div>
                                        <a href=""javascript:void(0)"" class=""text-muted text-decoration-none d-flex align-items-start fw-light""><span class=""material-icons md-20 me-2"">chat_bubble_outline</span><span");
            BeginWriteAttribute("class", " class=\"", 10344, "\"", 10389, 2);
            WriteAttributeValue("", 10352, "cmnt_count_", 10352, 11, true);
#nullable restore
#line 131 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 10363, Model.jobFeedList.ChJobID, 10363, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(">");
#nullable restore
#line 131 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                                                                                                                                                                                                                                                                Write(Model.jobFeedList.commentCount);

#line default
#line hidden
#nullable disable
            WriteLiteral("</span></a>\r\n                                    </div>\r\n\r\n                                    <div>\r\n                                        <a href=\"javascript:void(0)\" class=\"text-muted text-decoration-none d-flex align-items-start fw-light\"");
            BeginWriteAttribute("onclick", " onclick=\"", 10666, "\"", 10743, 3);
            WriteAttributeValue("", 10676, "ShareURL(\'https://cohyre.com/getjob?JD=", 10676, 39, true);
#nullable restore
#line 135 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 10715, Model.jobFeedList.ChJobID, 10715, 26, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 10741, "\')", 10741, 2, true);
            EndWriteAttribute();
            WriteLiteral(@"><span class=""material-icons md-18 me-2"">share</span><span>Share</span></a>
                                    </div>
                                </div>
                                <div class=""d-flex align-items-center"">
                                    <span class=""material-icons bg-white border-0 text-primary pe-2 md-36"">account_circle</span>
                                    <div class=""d-flex align-Models-center border rounded-4 px-3 py-1 w-100"">
                                        <input");
            BeginWriteAttribute("onkeyup", " onkeyup=\"", 11265, "\"", 11326, 4);
            WriteAttributeValue("", 11275, "Postcommentpop(\'", 11275, 16, true);
#nullable restore
#line 141 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 11291, Model.jobFeedList.ChJobID, 11291, 26, false);

#line default
#line hidden
#nullable disable
            WriteAttributeValue("", 11317, "\',", 11317, 2, true);
            WriteAttributeValue(" ", 11319, "event)", 11320, 7, true);
            EndWriteAttribute();
            WriteLiteral(" type=\"text\"");
            BeginWriteAttribute("id", " id=\"", 11339, "\"", 11378, 2);
            WriteAttributeValue("", 11344, "cmntpop_", 11344, 8, true);
#nullable restore
#line 141 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 11352, Model.jobFeedList.ChJobID, 11352, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            BeginWriteAttribute("JobAtr", " JobAtr=\"", 11379, "\"", 11414, 1);
#nullable restore
#line 141 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
WriteAttributeValue("", 11388, Model.jobFeedList.ChJobID, 11388, 26, false);

#line default
#line hidden
#nullable disable
            EndWriteAttribute();
            WriteLiteral(@" class=""form-control form-control-sm p-0 rounded-3 fw-light border-0 cmnt_box_popup"" placeholder=""Write Your comment"">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class=""modal-footer d-none"">
            </div>
        </div>
    </div>
    <script>
    $(document).ready(function () {
        debugger;
        var Is_modelFound = '");
#nullable restore
#line 157 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                        Write(Model.jobFeedList);

#line default
#line hidden
#nullable disable
            WriteLiteral("\';\r\n        if (Is_modelFound!= null) {\r\n            var jobid = \'");
#nullable restore
#line 159 "C:\Users\Lucky\source\repos\Application\Cohire\Cohire\Views\Home\GetPostDetails.cshtml"
                    Write(Model.jobFeedList.ChJobID);

#line default
#line hidden
#nullable disable
            WriteLiteral(@"';
            $(""#cmt_popup"").html('');
            $.ajax({
                url: ""../User/GetCommentForPost"",
                type: ""POST"",
                data: { jobID: jobid },
                success: function (data) {
                    debugger;
                    for (var i = 0; i < data.length; i++) {
                        var comments = data[i];
                        var commentHtml = '';
                        commentHtml = commentHtml + '<div class=""d-flex mb-2"">';
                        commentHtml = commentHtml + '<a href=""#"" class=""text-dark text-decoration-none"" data-bs-toggle=""modal"" data-bs-target=""#commentModal"">';
                        if (comments.profile_Image == null || comments.profile_Image == '') {
                            commentHtml = commentHtml + '<img src=""../images/customer-1.png"" class=""img-fluid rounded-circle"" alt=""commenters-img"">';
                        } else {
                            commentHtml = commentHtml + '<img src=""../images/Pro");
            WriteLiteral(@"fileImage/' + comments.profile_Image + '"" class=""img-fluid rounded-circle"" alt=""commenters-img"">';
                        }
                        commentHtml = commentHtml + '</a>';
                        commentHtml = commentHtml + '<div class=""ms-2 small"">';
                        commentHtml = commentHtml + ' <a href=""#"" class=""text-dark text-decoration-none"" data-bs-toggle=""modal"" data-bs-target=""#commentModal"">';
                        commentHtml = commentHtml + '<div class=""bg-light px-3 py-2 rounded-4 mb-1 chat-text"">';
                        commentHtml = commentHtml + '<p class=""fw-500 mb-0"">' + comments.fullName + '</p>';
                        commentHtml = commentHtml + '<span class=""text-muted"">' + comments.comment + '</span>';
                        commentHtml = commentHtml + '</div></a></div></div>';

                        $(""#cmt_popup"").append(commentHtml);
                        $(""#cmt_popup"").addClass('ex3pop');


                    }
                },
     ");
            WriteLiteral("           error: function (xhr, error, status) {\r\n                    console.log(error, status);\r\n                }\r\n            });\r\n        }\r\n\r\n    });\r\n    </script>");
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
        public global::Microsoft.AspNetCore.Mvc.Rendering.IHtmlHelper<Cohire.Models.JobFeedListNM.JobActionModel> Html { get; private set; }
    }
}
#pragma warning restore 1591
