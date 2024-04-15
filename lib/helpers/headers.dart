const defaultHeader = {
  'Connection': 'keep-alive',
  'User-Agent':
      'Mozilla/5.0 (iPhone; CPU iPhone OS 15_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.32(0x18002038) NetType/4G Language/zh_CN',
  'content-type': 'application/json',
  'merchant-id': '6267a80eed218542786f1494',
  'src': 'weixin_mini',
  'terminal-src': 'WEIXIN_MINI',
  'ver': '3.13.1',
  'Referer': 'https://servicewechat.com/wxad60dd8123a62329/252/page-frame.html'
};

Map<String, String> createHeaders(accessToken) {
  if (accessToken == null) {
    return defaultHeader;
  }

  var headers = Map<String, String>.from(defaultHeader);
  headers['accesstoken'] = accessToken;
  return headers;
}
