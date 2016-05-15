def stub_flickr
  response_body = { "photos":
                    { "page": 1,
                      "pages": 226_221,
                      "perpage": 10,
                      "total": "452442",
                      "photo":
                        [
                          { "id": "26909722332", "owner": "142979555@N05", "secret": "47d5f379e2", "server": "7316", "farm": 8, "title": "Testbilde 11:28 - 14.05", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
                          { "id": "26909405062", "owner": "96711656@N07", "secret": "ab0e2ff659", "server": "7617", "farm": 8, "title": "CBS201605141100.jpg", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
                        ]
                    },
                    "stat": "ok"
                  }.to_json

  stub_request(:post, 'https://api.flickr.com/services/rest/')
   .with(body: { method: 'flickr.photos.search', per_page: '10', text: 'test', format: 'json', nojsoncallback: '1' })
   .to_return(status: 200, body: response_body, headers: {})

  stub_request(:post, 'https://api.flickr.com/services/rest/')
   .with(body: { method: 'flickr.photos.getRecent', per_page: '10', format: 'json', nojsoncallback: '1' })
   .to_return(status: 200, body: response_body, headers: {})
end
