import 'package:app_ocotaxi/models/driver/drivers_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../view_models/providers/services/reservation_provider.dart';

class CustomButtonSelectDriver extends StatefulWidget {
  final User driver;
  final bool changeDriver;
  const CustomButtonSelectDriver({super.key, required this.driver, this.changeDriver = false});

  @override
  State<CustomButtonSelectDriver> createState() => _CustomButtonSelectDriverState();
}

class _CustomButtonSelectDriverState extends State<CustomButtonSelectDriver> {

  void selectDriver(){
    final provider = Provider.of<ReservationProvider>(context, listen: false);
    provider.setDriver(widget.driver);
  }
  void deleteDriver(){
    final provider = Provider.of<ReservationProvider>(context, listen: false);
    provider.deleteDriver();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepOrange,
        side: BorderSide(color: Colors.deepOrange, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      onPressed: (){
        if(widget.changeDriver){
          deleteDriver();
        }else{
          selectDriver();
          context.pop();
        }
      },
      child: Text(widget.changeDriver?"Eliminar":"Seleccionar"),
    );
  }
}
