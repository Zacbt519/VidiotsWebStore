using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VidiotsWebStore
{
    public partial class AdminSearchResults : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"].ToString() != "Admin")
            {
                Response.Redirect("../index.aspx");
            }
            master = (VidiotsAdminTemplate)this.Master;
            string searchTerm = Request.QueryString["searchTerm"];
            if (!string.IsNullOrEmpty(searchTerm))
            {
                GetResults(searchTerm);
            }

            if (IsPostBack)
            {
                master.masterMessage = "";
            }
        }

        private void GetResults(string searchTerm)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetSearchResults @input = " + searchTerm, conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        rptResults.DataSource = dr;
                        rptResults.DataBind();
                    }
                    else
                    {

                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                dr.Close();
            }
        }

        
    }
}