﻿<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // preload all BGF from disk to RAM
        BgfCache.Preload();

        // warning: don't use cache, it has no limits so far
        Meridian59.Drawing2D.ImageComposerNative<Meridian59.Data.Models.ObjectBase>.Cache.IsEnabled = false;
        Meridian59.Drawing2D.ImageComposerGDI<Meridian59.Data.Models.ObjectBase>.Cache.IsEnabled = false;

        // interpolation mode for GDI+ alpha-blending/scaling
        Meridian59.Drawing2D.ImageComposerGDI<Meridian59.Data.Models.ObjectBase>.InterpolationMode =
            System.Drawing.Drawing2D.InterpolationMode.Default;

        // ----------------------------------------------------------------

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "file/{file}/{req}/{parm1}/{parm2}/{parm3}", new HttpHandlerRoute("~/file.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "file/{file}/{req}/{parm1}/{parm2}", new HttpHandlerRoute("~/file.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "file/{file}/{req}/{parm1}", new HttpHandlerRoute("~/file.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "file/{file}/{req}", new HttpHandlerRoute("~/file.ashx")));

        // ----------------------------------------------------------------
        
        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "object/{file}/{group}/{palette}/{angle}", new HttpHandlerRoute("~/Object.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "object/{file}/{group}/{palette}", new HttpHandlerRoute("~/Object.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "object/{file}/{group}", new HttpHandlerRoute("~/Object.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "object/{file}", new HttpHandlerRoute("~/Object.ashx")));

        // ----------------------------------------------------------------

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "render/{width}/{height}/{scale}/{file}/{group}/{palette}/{angle}", new HttpHandlerRoute("~/Render.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "render/{width}/{height}/{scale}/{file}/{group}/{palette}", new HttpHandlerRoute("~/Render.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "render/{width}/{height}/{scale}/{file}/{group}", new HttpHandlerRoute("~/Render.ashx")));

        System.Web.Routing.RouteTable.Routes.Add(new System.Web.Routing.Route(
            "render/{width}/{height}/{scale}/{file}", new HttpHandlerRoute("~/Render.ashx")));
    }

    void Application_End(object sender, EventArgs e)
    {

    }

    void Application_Error(object sender, EventArgs e)
    {

    }

    void Session_Start(object sender, EventArgs e)
    {

    }

    void Session_End(object sender, EventArgs e)
    {

    }

</script>
