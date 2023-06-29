import 'package:flutter/material.dart';
import 'package:oga_bliss/util/common.dart';

class Terms_N_Conditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorPrimary,
        title: const Text(
          'End-User License Agreement',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'End-User License Agreement (EULA) of Oga Bliss',
                style: TextStyle(fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'This End-User License Agreement ("EULA") is a legal agreement between you and Oga Bliss',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'This EULA agreement governs your acquisition and use of our Oga Bliss software ("Software") directly from Oga Bliss or indirectly through a Oga Bliss authorized reseller or distributor (a "Reseller").',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Please read this EULA agreement carefully before completing the installation process and using the Oga Bliss software. It provides a license to use the Oga Bliss software and contains warranty information and liability disclaimers.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'If you register for a free trial of the Oga Bliss software, this EULA agreement will also govern that trial. By clicking "accept" or installing and/or using the Oga Bliss software, you are confirming your acceptance of the Software and agreeing to become bound by the terms of this EULA agreement.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'If you are entering into this EULA agreement on behalf of a company or other legal entity, you represent that you have the authority to bind such entity and its affiliates to these terms and conditions. If you do not have such authority or if you do not agree with the terms and conditions of this EULA agreement, do not install or use the Software, and you must not accept this EULA agreement.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'This EULA agreement shall apply only to the Software supplied by Oga Bliss herewith regardless of whether other software is referred to or described herein. The terms also apply to any Oga Bliss updates, supplements, Internet-based services, and support services for the Software, unless other terms accompany those items on delivery. If so, those terms apply.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'License Grant',
                style: TextStyle(fontSize: 25.0, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Oga Bliss hereby grants you a personal, non-transferable, non-exclusive licence to use the Oga Bliss software on your devices in accordance with the terms of this EULA agreement.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'You are permitted to load the Oga Bliss software (for example a PC, laptop, mobile or tablet) under your control. You are responsible for ensuring your device meets the minimum requirements of the Oga Bliss software.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'You are not permitted to:',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                '*Edit, alter, modify, adapt, translate or otherwise change the whole or any part of the Software nor permit the whole or any part of the Software to be combined with or become incorporated in any other software, nor decompile, disassemble or reverse engineer the Software or attempt to do any such things',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                '*Reproduce, copy, distribute, resell or otherwise use the Software for any commercial purpose',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                '*Allow any third party to use the Software on behalf of or for the benefit of any third party',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                '*Use the Software in any way which breaches any applicable local, national or international law',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                '*use the Software for any purpose that Oga Bliss considers is a breach of this EULA agreement',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Intellectual Property and Ownership',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Oga Bliss shall at all times retain ownership of the Software as originally downloaded by you and all subsequent downloads of the Software by you. The Software (and the copyright, and other intellectual property rights of whatever nature in the Software, including any modifications made thereto) are and shall remain the property of Oga Bliss.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Oga Bliss reserves the right to grant licences to use the Software to third parties.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Termination',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'This EULA agreement is effective from the date you first use the Software and shall continue until terminated. You may terminate it at any time upon written notice to Oga Bliss.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'It will also terminate immediately if you fail to comply with any term of this EULA agreement. '
                'Upon such termination, the licenses granted by this EULA agreement will immediately terminate '
                'and you agree to stop all access and use of the Software.'
                ' The provisions that by their nature continue and survive will survive any termination of this EULA agreement. '
                // 'This EULA was created by App EULA Template Generator  for Oga Bliss'
                ,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: Text(
                'Governing Law',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 40.0),
              child: Text(
                'This EULA agreement, and any dispute arising out of or in connection with this EULA agreement, shall be governed by and construed in accordance with the laws of ng.',
                style: TextStyle(
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
