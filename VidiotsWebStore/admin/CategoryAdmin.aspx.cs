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
    public partial class CategoryAdmin : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
            if (!IsPostBack)
            {
                GetCategories();
            }
        }

        private void GetCategories()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);

            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetAllCategories", conn);
                    conn.Open();

                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);

                    if (dr.HasRows)
                    {
                        rptCategories.DataSource = dr;
                        rptCategories.DataBind();
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