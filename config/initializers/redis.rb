$redis_params = {
  connect_timeout: 2,
  read_timeout: 0.2,
  write_timeout: 0.2,
  reconnect_attempts: 1,
  host: Rails.application.credentials.dig(:redis, :host),
  port: Rails.application.credentials.dig(:redis, :port),
  password: Rails.application.credentials.dig(:redis, :password)
}

connection_pool_params = {size: 25, timeout: 0.1}

# Fast
#   $redis.with {|conn| conn.get }
# Slightly slower, but easier to use
#   $redis.get
$redis = ConnectionPool::Wrapper.new(connection_pool_params) { Redis.new($redis_params) }

$in_memory_data = []

$random_data = [
  {
    "_id": "643d4b12b0975bc506d50708",
    "index": 0,
    "guid": "d715fcbe-e6be-4080-b0e5-d75e413e5ef3",
    "isActive": false,
    "balance": "$3,113.45",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "brown",
    "name": "Isabelle Norman",
    "gender": "female",
    "company": "AFFLUEX",
    "email": "isabellenorman@affluex.com",
    "phone": "+1 (808) 560-3075",
    "address": "481 Lacon Court, Kaka, Hawaii, 1813",
    "about": "Veniam commodo nisi irure reprehenderit incididunt exercitation culpa. Eu consectetur velit do labore. Ea do qui deserunt voluptate amet cupidatat adipisicing sint magna. Fugiat laboris sunt laborum ullamco. Velit consequat aliqua ex exercitation nulla aliqua laboris qui commodo eu sit. Do tempor id nulla quis nostrud officia quis minim qui sint. In cupidatat dolore deserunt cupidatat.\r\n",
    "registered": "2021-08-17T11:10:55 -06:-30",
    "latitude": -79.466089,
    "longitude": -125.957482,
    "tags": [
      "occaecat",
      "sunt",
      "adipisicing",
      "in",
      "aliquip",
      "reprehenderit",
      "est"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Morse Nash"
      },
      {
        "id": 1,
        "name": "Esperanza Cole"
      },
      {
        "id": 2,
        "name": "Allison Brock"
      }
    ],
    "greeting": "Hello, Isabelle Norman! You have 3 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "643d4b12873af466a5237540",
    "index": 1,
    "guid": "d6378973-1b8e-41b0-98f7-d7ebeb8cf909",
    "isActive": false,
    "balance": "$1,499.85",
    "picture": "http://placehold.it/32x32",
    "age": 33,
    "eyeColor": "brown",
    "name": "Allison Drake",
    "gender": "female",
    "company": "DANJA",
    "email": "allisondrake@danja.com",
    "phone": "+1 (972) 525-3173",
    "address": "961 Sackett Street, Chesterfield, California, 5268",
    "about": "Ex voluptate mollit ullamco cillum incididunt veniam magna id non pariatur velit cillum. Lorem nostrud nulla mollit minim laborum. Officia nostrud do proident enim. In elit ea est aliqua cupidatat id eu consectetur incididunt. Duis enim non commodo sit excepteur fugiat consequat consectetur reprehenderit excepteur. Aliquip et consectetur quis proident do. Et elit minim voluptate do dolore laborum deserunt magna.\r\n",
    "registered": "2020-03-07T03:16:59 -06:-30",
    "latitude": -75.76264,
    "longitude": 87.478681,
    "tags": [
      "proident",
      "velit",
      "nisi",
      "sint",
      "irure",
      "anim",
      "duis"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Andrews Murray"
      },
      {
        "id": 1,
        "name": "Welch Morrison"
      },
      {
        "id": 2,
        "name": "Cheryl Norris"
      }
    ],
    "greeting": "Hello, Allison Drake! You have 9 unread messages.",
    "favoriteFruit": "banana"
  },
  {
    "_id": "643d4b12e8e49a45f895d705",
    "index": 2,
    "guid": "82177d8d-b82a-4a8a-b526-4c94a612e054",
    "isActive": false,
    "balance": "$2,895.33",
    "picture": "http://placehold.it/32x32",
    "age": 31,
    "eyeColor": "brown",
    "name": "Walter Dunn",
    "gender": "male",
    "company": "FUTURIS",
    "email": "walterdunn@futuris.com",
    "phone": "+1 (829) 467-2392",
    "address": "109 Raleigh Place, Ilchester, Marshall Islands, 1779",
    "about": "Adipisicing ad esse et eu. Nisi culpa non consectetur aliqua ex eu nostrud ullamco voluptate. Id dolor proident cupidatat dolor laborum qui culpa exercitation eu. Eu ad dolor adipisicing eu incididunt laboris qui veniam Lorem.\r\n",
    "registered": "2014-09-07T10:49:43 -06:-30",
    "latitude": 89.701985,
    "longitude": 84.698767,
    "tags": [
      "sunt",
      "Lorem",
      "elit",
      "nostrud",
      "id",
      "adipisicing",
      "voluptate"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Rhoda Chen"
      },
      {
        "id": 1,
        "name": "Janna Howell"
      },
      {
        "id": 2,
        "name": "Aguilar Benton"
      }
    ],
    "greeting": "Hello, Walter Dunn! You have 5 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "643d4b12bfab2af052a7396e",
    "index": 3,
    "guid": "1adc4c62-31f4-49ef-a741-8a636cd0d34e",
    "isActive": true,
    "balance": "$1,578.30",
    "picture": "http://placehold.it/32x32",
    "age": 40,
    "eyeColor": "brown",
    "name": "Hicks Clark",
    "gender": "male",
    "company": "WRAPTURE",
    "email": "hicksclark@wrapture.com",
    "phone": "+1 (844) 544-3195",
    "address": "635 Lefferts Avenue, Rosedale, Nevada, 9372",
    "about": "Incididunt cillum consequat nulla aliqua ea consectetur esse excepteur ipsum mollit in enim sint. Lorem esse ullamco est laborum eiusmod adipisicing. Occaecat ad nisi veniam laborum amet qui non incididunt pariatur magna duis velit sint sunt. Id adipisicing incididunt occaecat dolore.\r\n",
    "registered": "2020-06-22T03:29:14 -06:-30",
    "latitude": 87.598352,
    "longitude": 65.933499,
    "tags": [
      "adipisicing",
      "tempor",
      "pariatur",
      "nisi",
      "Lorem",
      "in",
      "aute"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Gladys Henry"
      },
      {
        "id": 1,
        "name": "Wiggins Dickerson"
      },
      {
        "id": 2,
        "name": "Amalia Evans"
      }
    ],
    "greeting": "Hello, Hicks Clark! You have 5 unread messages.",
    "favoriteFruit": "apple"
  },
  {
    "_id": "643d4b12bd2592d7a20eaa60",
    "index": 4,
    "guid": "12727cb9-da92-49d0-84bd-c461a1417161",
    "isActive": true,
    "balance": "$2,930.11",
    "picture": "http://placehold.it/32x32",
    "age": 26,
    "eyeColor": "brown",
    "name": "Kennedy Sharp",
    "gender": "male",
    "company": "KRAGGLE",
    "email": "kennedysharp@kraggle.com",
    "phone": "+1 (808) 527-2059",
    "address": "278 Lois Avenue, Clarence, Federated States Of Micronesia, 8733",
    "about": "Tempor officia ipsum tempor voluptate nulla duis consequat exercitation. Nostrud pariatur amet enim esse quis. Commodo culpa veniam dolore Lorem tempor dolore consequat ea. Irure deserunt esse non sint ex irure laborum.\r\n",
    "registered": "2017-05-26T04:46:23 -06:-30",
    "latitude": 85.460506,
    "longitude": 15.315292,
    "tags": [
      "labore",
      "incididunt",
      "esse",
      "cillum",
      "cillum",
      "elit",
      "nostrud"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Doreen Hahn"
      },
      {
        "id": 1,
        "name": "Lowery Rogers"
      },
      {
        "id": 2,
        "name": "Priscilla Pacheco"
      }
    ],
    "greeting": "Hello, Kennedy Sharp! You have 9 unread messages.",
    "favoriteFruit": "strawberry"
  },
  {
    "_id": "643d4b1209baed9fa7c28163",
    "index": 5,
    "guid": "3e64dd6a-fb10-422b-8829-3e8470f84def",
    "isActive": true,
    "balance": "$3,512.88",
    "picture": "http://placehold.it/32x32",
    "age": 37,
    "eyeColor": "blue",
    "name": "Tate Wade",
    "gender": "male",
    "company": "FREAKIN",
    "email": "tatewade@freakin.com",
    "phone": "+1 (920) 586-2541",
    "address": "924 Stoddard Place, Irwin, Iowa, 2176",
    "about": "Voluptate consequat qui elit adipisicing est voluptate dolore aute. Nostrud officia excepteur sunt irure cillum proident commodo duis consectetur consectetur consequat proident irure tempor. Enim pariatur nulla deserunt culpa. Ullamco commodo ad enim aute aliqua et aliqua officia id veniam et. Nisi amet laboris sunt veniam id aute fugiat. Sunt pariatur enim eu mollit elit est ut pariatur exercitation labore pariatur anim aliquip.\r\n",
    "registered": "2020-03-15T03:41:49 -06:-30",
    "latitude": 48.171817,
    "longitude": 119.619258,
    "tags": [
      "et",
      "anim",
      "ex",
      "mollit",
      "anim",
      "anim",
      "magna"
    ],
    "friends": [
      {
        "id": 0,
        "name": "Eugenia Payne"
      },
      {
        "id": 1,
        "name": "Dickson Velazquez"
      },
      {
        "id": 2,
        "name": "Long Cabrera"
      }
    ],
    "greeting": "Hello, Tate Wade! You have 4 unread messages.",
    "favoriteFruit": "strawberry"
  }
]