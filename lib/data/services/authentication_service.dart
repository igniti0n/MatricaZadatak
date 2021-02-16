import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import './shared_prefs_service.dart';

const String
    _authenticationLink = //"https://matrica.hr:6400/Auth/create_token";
    "https://salvis.hr:4700/api/auth/create_token";

class AuthenticationService {
  Future<void> login() async {
    try {
      final http.Response _response = await http.post(
        _authenticationLink,
        body: json
            .encode({'username': "ivan", 'password': "Kruno Denis Ivan \$321"}),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
      );
      log(_response.body);
      log(_response.statusCode.toString());
      await SharedPreferencesService.saveToken(
          json.decode(_response.body)['Token']);

      // final String _token = await SharedPreferencesService.getToken();
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

//   Future<void> faks() async {
//     try {
//       final Map<String, dynamic>
// data = {
//         "Inputs": {
//           "input1": {
//             "ColumnNames": [
//               "p1",
//               "p2",
//               "p3",
//               "p4",
//               "p5",
//               "p6",
//               "p7",
//               "p8",
//               "p9",
//               "p10",
//               "p11",
//               "p12",
//               "p13",
//               "p14",
//               "p15",
//               "p16",
//               "p17",
//               "p18",
//               "p19",
//               "p20",
//               "p21",
//               "p22",
//               "p23",
//               "p24",
//               "p25",
//               "p26",
//               "p27",
//               "p28",
//               "p29",
//               "p30",
//               "p31",
//               "p32",
//               "p33",
//               "p34",
//               "p35",
//               "p36",
//               "p37",
//               "p38",
//               "p39",
//               "p40",
//               "p41",
//               "p42",
//               "p43",
//               "p44",
//               "p45",
//               "p46",
//               "p47",
//               "p48",
//               "p49",
//               "p50",
//               "p51",
//               "p52",
//               "p53",
//               "p54",
//               "p55",
//               "p56",
//               "p57",
//               "p58",
//               "p59",
//               "p60",
//               "p61",
//               "p62",
//               "p63",
//               "p64",
//               "p65",
//               "p66",
//               "p67",
//               "p68",
//               "p69",
//               "p70",
//               "p71",
//               "p72",
//               "p73",
//               "p74",
//               "p75",
//               "p76",
//               "p77",
//               "p78",
//               "p79",
//               "p80",
//               "Class"
//             ],
//             "Values": [
//               [
//                 " -0.003088235",
//                 "0",
//                 "0",
//                 "0.000555556",
//                 "0.0025",
//                 "0.000555556",
//                 "	0.0025",
//                 "0.000277778",
//                 "0",
//                 "0.005898693",
//                 "	-0.003088235",
//                 "0",
//                 "	-0.003888889",
//                 "-0.008218954",
//                 "	0.031654118",
//                 "	0.009640523",
//                 "	0.060245098",
//                 "	0.052095294",
//                 "	0.000277778",
//                 "	0.005343137",
//                 "	-0.003088235",
//                 "	0",
//                 "	-0.005",
//                 "	-0.070759216",
//                 "	0.015726536",
//                 "	0.019558824",
//                 "	0.161078431",
//                 "	0.081879085	",
//                 "0.000277778",
//                 "	0.005343137	",
//                 "-0.003088235	",
//                 "0	",
//                 "-0.0025",
//                 "	-0.098745621",
//                 "	-0.005649804",
//                 "	0.074685752",
//                 "	0.156160131",
//                 "	0.076601307",
//                 "	0",
//                 "	0.005343137	",
//                 "-0.003088235	",
//                 "0	",
//                 "-0.002777778",
//                 "	-0.024350196",
//                 "	-0.036793595",
//                 "	0.108378562",
//                 "	0.092340392",
//                 "	0.076045752",
//                 "	0	",
//                 "0.005343137",
//                 "	-0.003088235",
//                 "	0",
//                 "	-0.001666667",
//                 "	-0.008598562	",
//                 "-0.087790327",
//                 "	0.120555556",
//                 "	0.03254902	",
//                 "0.045604575	",
//                 "0",
//                 "	0.005343137",
//                 "	-0.003088235",
//                 "	0",
//                 "	0	",
//                 "0.000555556",
//                 "	-0.025915033",
//                 "	0.07496732",
//                 "	0.007859477",
//                 "	0.000277778",
//                 "	0",
//                 "	0.005343137",
//                 "	-0.003088235",
//                 "	0",
//                 "	0	",
//                 "0",
//                 "	-0.000277778",
//                 "	0.000833333",
//                 "0",
//                 "	0",
//                 "	0	",
//                 "0.005343137",
//                 ""
//               ]
//             ]
//           },
//         },
//         "GlobalParameters": {}
//       };

//       final String api_key =
//           'DEnwZOItPxuzXqYLGKi9IHg9yyTOv1YFPwAGJVtwH4Q6J3bvmrsr3xGbbQJAxtUI1yOax51nDo/JVNU8tJHa2Q==';

//       final http.Response _response = await http.post(
//         'https://ussouthcentral.services.azureml.net/workspaces/c0b4ca8ee9184b3bb5a36a323f73602b/services/50bb756d50264a2dbc46049872b09b8e/execute?api-version=2.0&details=true',
//         body: json.encode(data),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': ('Bearer ' + api_key)
//         },
//       );
//       log(_response.body);
//       log(_response.statusCode.toString());
//     } catch (error) {
//       print(error.toString());
//       throw error;
//     }
//
//
}
