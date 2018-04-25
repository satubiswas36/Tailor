package baseurl;

import javax.servlet.http.HttpServletRequest;

public class BaseUrl {

    public static String getBaseUrl(HttpServletRequest request,String url) {
        String baseUrl = request.getRequestURL().substring(0, request.getRequestURL().length() - request.getRequestURI().length()) + request.getContextPath();
        return baseUrl+"/"+url;
    }
}
