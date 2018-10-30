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
    public partial class ArchiveCustomer : System.Web.UI.Page
    {
        private string strConn = ConfigurationManager.ConnectionStrings["cnn"].ConnectionString;
        VidiotsAdminTemplate master;
        protected void Page_Load(object sender, EventArgs e)
        {
            master = (VidiotsAdminTemplate)this.Master;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchCustomers();
        }

        private void SearchCustomers()
        {
            SqlDataReader dr = default(SqlDataReader);
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spCustomerSearch", conn);
                    SqlParameter param = new SqlParameter("@Term", txtSearch.Text);
                    cmd.Parameters.Add(param);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                    if (dr.HasRows)
                    {
                        grvCustomers.DataSource = dr;
                        grvCustomers.DataBind();
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

        protected void btnArchive_Click(object sender, EventArgs e)
        {
            int i = 0;
            foreach (GridViewRow row in grvCustomers.Rows)
            {
                
                CheckBox chk = (CheckBox)row.FindControl("chkArchived");

                if (chk.Checked == true)
                {
                    string customerId = grvCustomers.Rows[i].Cells[0].Text;

                    ArchiveCustomers(customerId);
                }

                i++;
            }
        }

        private void ArchiveCustomers(string customerId)
        {
            SqlCommand cmd = default(SqlCommand);
            try
            {
                using (SqlConnection conn = new SqlConnection(strConn))
                {
                    cmd = new SqlCommand("spArchiveCustomer", conn);
                    SqlParameter param = new SqlParameter("@CustomerID", customerId);
                    cmd.Parameters.Add(param);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                master.masterMessage = ex.Message;
            }
            finally
            {
                master.masterMessage = "Customers Archived.";
            }
        }
    }
}