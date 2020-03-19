class Url
{
  static const _BASE_ADDR = "https://news-ws-chfmsoli4q-ew.a.run.app";

  static const NEWS_GET = _BASE_ADDR+"/news-ws/news";
  static const LIKE_POST = _BASE_ADDR+"/news-ws/news/%s/like";
  static const LIKE_GET = _BASE_ADDR+"/news-ws/news/%s/like";
  static const UNLIKE_POST = _BASE_ADDR+"/news-ws/news/%s/unlike";
  static const NEW_POST = _BASE_ADDR+"/news-ws/posts/";
  static const PUT_POST = _BASE_ADDR+"/news-ws/posts/%s";
  static const GET_MY_POSTS = _BASE_ADDR+"/news-ws/posts";
  static const DELETE_POST = _BASE_ADDR+"/news-ws/posts/%s";

  static const FIND_NEWS_URL = "http://newsapi.org/v2/everything?q=google&apiKey=234b89ba6c3b46a59deca33e7036feed";
}