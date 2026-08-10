using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MY_PROJECT
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateHeaderUserName();
            }
        }

        private void UpdateHeaderUserName()
        {
            string displayName = string.Empty;

            // 1. Check Session State (Username first, then FullName)
            if (Session["Username"] != null && !string.IsNullOrEmpty(Convert.ToString(Session["Username"])))
            {
                displayName = Convert.ToString(Session["Username"]);
            }
            else if (Session["FullName"] != null && !string.IsNullOrEmpty(Convert.ToString(Session["FullName"])))
            {
                displayName = Convert.ToString(Session["FullName"]);
            }

            // 2. Check Cookie Recovery if Session is empty
            if (string.IsNullOrEmpty(displayName))
            {
                HttpCookie userCookie = Request.Cookies["UserLoginCookie"];
                if (userCookie != null)
                {
                    if (!string.IsNullOrEmpty(userCookie["Username"]))
                    {
                        displayName = userCookie["Username"];
                    }
                    else if (!string.IsNullOrEmpty(userCookie["FullName"]))
                    {
                        displayName = userCookie["FullName"];
                    }
                }
            }

            // 3. Update Controls safely
            if (!string.IsNullOrEmpty(displayName))
            {
                // After Login or Registration: Show registered User Name
                if (lblHeaderUserName != null)
                {
                    lblHeaderUserName.Text = displayName;
                }
                if (lnkHeaderAuth != null)
                {
                    lnkHeaderAuth.HRef = "Dashboard.aspx";
                }
                if (lnkOffcanvasAuth != null)
                {
                    lnkOffcanvasAuth.HRef = "Dashboard.aspx";
                    lnkOffcanvasAuth.InnerHtml = "<i class=\"fa fa-user-circle\"></i> " + displayName;
                }
            }
            else
            {
                // Initial site load (not logged in): Show "Admin"
                if (lblHeaderUserName != null)
                {
                    lblHeaderUserName.Text = "Admin";
                }
                if (lnkHeaderAuth != null)
                {
                    lnkHeaderAuth.HRef = "Login.aspx";
                }
                if (lnkOffcanvasAuth != null)
                {
                    lnkOffcanvasAuth.HRef = "Login.aspx";
                    lnkOffcanvasAuth.InnerHtml = "<i class=\"fa fa-user-circle\"></i> Admin";
                }
            }
        }
    }
}