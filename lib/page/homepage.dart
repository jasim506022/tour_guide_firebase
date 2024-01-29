import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade50,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        "https://w7.pngwing.com/pngs/26/907/png-transparent-shahid-afridi-2017-t10-cricket-league-jersey-t10-league-cricket-tshirt-sport-sports-thumbnail.png",
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jasim Uddin",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Text(
                          "Dhaka, Bangladesbh",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 14,
                      child: TextFormField(
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.black,
                            )),
                            child: Icon(Icons.settings)))
                  ],
                ),
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.black,
                  padding: const EdgeInsets.all(10),
                  indicatorWeight: 4,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: GoogleFonts.dmSans(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  labelStyle: GoogleFonts.dmSans(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "FAQ",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text("Contact Us",
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
