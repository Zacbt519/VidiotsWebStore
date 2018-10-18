<%@ Page Title="" Language="C#" MasterPageFile="~/admin/VidiotsAdminTemplate.Master" AutoEventWireup="true" CodeBehind="ArchiveCustomer.aspx.cs" Inherits="VidiotsWebStore.ArchiveCustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-8">
                <h3>Search Customers</h3>
                <div class="input-group">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"></asp:TextBox>
                    &nbsp;
                    <span class="input-group-btn">
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-success" OnClick="btnSearch_Click" />
                    </span>
                </div>
                <br />
            </div>
        </div>
        <div class="row">
            <div class="col-8">
                <ul class="list-group">
                    <asp:SqlDataSource ID="sqlGRV" runat="server" ConnectionString="<%$ ConnectionStrings:cnn %>" SelectCommand="spCustomerSearch" SelectCommandType="StoredProcedure" UpdateCommand="spArchiveCustomer" UpdateCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtSearch" DefaultValue="" Name="Term" PropertyName="Text" Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="CustomerID" Type="Int16" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                    
                </ul>
            </div>
        </div>
    </div>
    <asp:GridView ID="grvCustomers" runat="server" AutoGenerateColumns="False" DataKeyNames="CustomerID" DataSourceID="sqlGRV">
        <Columns>
            <asp:CommandField EditText="Archive" ShowEditButton="True" UpdateText="Confirm" />
            <asp:BoundField DataField="CustomerName" HeaderText="CustomerName" ReadOnly="True" SortExpression="CustomerName" />
            <asp:CheckBoxField DataField="IsArchived" HeaderText="IsArchived" SortExpression="IsArchived" />
            <asp:BoundField DataField="CustomerID" HeaderText="CustomerID" InsertVisible="False" ReadOnly="True" SortExpression="CustomerID" />
        </Columns>
    </asp:GridView>
</asp:Content>
