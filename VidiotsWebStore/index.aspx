<%@ Page Title="" Language="C#" MasterPageFile="~/VidiotsTemplate.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="VidiotsWebStore.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <h1>Featured Items</h1>
        <br />
        
                <ul class="list-group">
                <asp:Repeater ID="rptFeaturedProducts" runat="server">
                <ItemTemplate>
                    <li class="list-group-item">
                        <asp:Image ID="productImage" CssClass="img-responsive img-thumbnail searchResultsImg" ImageUrl='<%# Eval("ImageURL") %>' AlternateText='<%# Eval("AltText") %>' Visible="true" runat="server" />
                        <h4 class=""><%# Eval("ProductName") %></h4>
                        <h6>Product ID: <span><%# Eval("ProductID") %></span></h6>
                        <h5>Brief Description: </h5>
                        <p><%# Eval("BriefDescription") %></p>
                        <h6>Price: </h6>
                        <p><%# Eval("Price","{0:c}") %></p>
                        <a href='ProductFullView.aspx?productId=<%# Eval("ProductID") %>' class="btn btn-primary">See more</a>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
                     </ul> 
            </div>
        
       
            
                
            
            
        </div>
            
          
        
    
</asp:Content>
