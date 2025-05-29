import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../view_models/providers/location/location_provider.dart';

class HeaderLocation extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final String url;
  const HeaderLocation({super.key, this.url = "", this.backButton = false});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<HeaderLocation> createState() => _HeaderLocationState();
}

class _HeaderLocationState extends State<HeaderLocation> {
  @override
  void initState() {
    super.initState();
    // Obtener la ubicación al inicializar el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(context, listen: false).getLocationUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(120),
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) {
          final location = locationProvider?.location?.first;

          return Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        widget.backButton == true
                            ? GestureDetector(
                          onTap: (){
                            if(widget.url.isEmpty){
                              context.pop();
                            }else{
                              context.pushReplacement(widget.url);
                            }
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                        )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        const Text(
                          "Ubicación",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            location != null
                                ? "${location.thoroughfare ?? ''}, ${location.locality ?? ''}"
                                : "Obteniendo ubicación...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}