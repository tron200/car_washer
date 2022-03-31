import 'package:flutter/material.dart';

class Service{
  TextEditingController _controller;
  String _service_id;
  Service( this._controller, this._service_id);
  TextEditingController getController(){
    return _controller;
  }
  String getServiceId(){
    return _service_id;
  }

  void set controller(TextEditingController controller) => _controller = controller;


  void set service_id(String service_id) => _service_id = service_id;

}