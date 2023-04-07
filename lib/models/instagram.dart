import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'instamedia.dart';

class Instagram {

  static const String clientID = '586078193405067';
  static const String appSecret = '6ebee4e473baad99d45e6737886493b2';
  static const String redirectUri = 'api.instagram.maxence';
  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';
  static const String url =
      'https://api.instagram.com/oauth/authorize?client_id=${clientID}&redirect_uri=${redirectUri}&scope=${scope}&response_type=${responseType}';

  List<String> userFields = ['id', 'username'];
  List<String> mediasListFields = ['id', 'caption'];
  List<String> mediaFields = [
    'id',
    'media_type',
    'media_url',
    'username',
    'timestamp'
  ];
  
  void getAuthorizationCode(String url) {
    var authorizationCode =
    url.replaceAll('${redirectUri}?code=', '').replaceAll('#_', '');
  }
}

  Future<bool> getTokenAndUserID() async {
    /// Request token.
    /// Set token.
    /// Returning status request as bool.
    var http;
    var clientID;
    var redirectUri;
    var appSecret;
    var authorizationCode;
    final http.Response response =
    await http.post("https://api.instagram.com/oauth/access_token", body: {
      "client_id": clientID,
      "redirect_uri": redirectUri,
      "client_secret": appSecret,
      "code": authorizationCode,
      "grant_type": "authorization_code"
    });
    var accessToken = json.decode(response.body)['access_token'];
    var userID = json.decode(response.body)['user_id'].toString();
    return (accessToken != null && userID != null) ? true : false;
  }

  Future<bool> getUserProfile() async {
    /// Parse according fieldsList.
    /// Request instagram user profile.
    /// Set profile.
    /// Returning status request as bool.
    var userFields;
    final String fields = userFields.join(',');
    var userID;
    var accessToken;
    final http.Response responseNode = await http.get(
        'https://graph.instagram.com/${userID}?fields=${fields}&access_token=${accessToken}');
    var instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
    };
    return (instaProfile != null) ? true : false;
  }
  Future<List> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    var mediasListFields;
    final String fields = mediasListFields.join(',');
    var userID;
    var accessToken;
    final http.Response responseMedia = await http.get(
        'https://graph.instagram.com/${userID}/media?fields=${fields}&access_token=${accessToken}');
    Map<String, dynamic> mediasList = json.decode(responseMedia.body);
    var medias = [];
    await mediasList['data'].forEach((media) async {
      // check inside db if exists (optional)
      Map<String, dynamic> m = await getMediaDetails(media['id']);
      InstaMedia instaMedia = InstaMedia(m);
      medias.add(instaMedia);
    });
    await Future.delayed(Duration(seconds: 1), () {});
    return medias;
  }
  
    Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    var mediaFields;
    final String fields = mediaFields.join(',');
    var accessToken;
    final http.Response responseMediaSingle = await http.get(
        'https://graph.instagram.com/${mediaID}?fields=${fields}&access_token=${accessToken}');
    return json.decode(responseMediaSingle.body);
  }