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
    public partial class index : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsTemplate master;
        protected void Page_PreInit(object sender, EventArgs e)
        {
            try
            {
                if (Session["UserType"].ToString() == "Admin")
                {
                    this.MasterPageFile = "~/admin/VidiotsAdminTemplate.Master";
                    Session["MasterType"] = "Admin";
                }
                else if (Session["UserType"].ToString() == "Customer" || Session["UserType"] == null)
                {
                    this.MasterPageFile = "~VidiotsTemplate.Master";
                    Session["MasterType"] = "User";
                }
            }

            catch(Exception ex)
            {

            }
            
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Session["MasterType"] is null)
                    {
                        GetFeaturedProducts();

                    }
                    else
                    {
                        
                    }
                }
                catch(Exception ex)
                {

                }
               
                
            }
        }
        
        private void GetFeaturedProducts()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetFeaturedProducts", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    
                    if (dr.HasRows)
                    {
                        rptFeaturedProducts.DataSource = dr;
                        rptFeaturedProducts.DataBind();
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