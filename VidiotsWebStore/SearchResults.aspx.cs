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
    public partial class SearchResults : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsTemplate)this.Master;
            string searchTerm = Request.QueryString["searchTerm"];
            if(!string.IsNullOrEmpty(searchTerm))
            {
                GetResults(searchTerm);
                
            }
            else
            {
                master.masterMessage = "No search term entered";
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
                        dr.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            
        }

        
    }
}