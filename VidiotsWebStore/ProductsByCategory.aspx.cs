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
    public partial class ProductsByCategory : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            string catId = Request.QueryString["categoryID"];
            
            string type = Request.QueryString["prodType"];
            if (!string.IsNullOrEmpty(catId))
            {
                GetProducts(catId, type);
            }
        }

        private void GetProducts(string catId, string type)
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spGetProductsByCategory", conn);
                    SqlParameter param = new SqlParameter("@CategoryID", int.Parse(catId));
                    cmd.Parameters.Add(param);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (dr.HasRows)
                    {
                        rptProducts.DataSource = dr;
                        rptProducts.DataBind();
                    }
                    else
                    {
                    }
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                dr.Close();
            }
        }
    }
}