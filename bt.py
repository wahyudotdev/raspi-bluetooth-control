from bluetooth import *
import RPi.GPIO as GPIO
import os
from time import sleep
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
GPIO.setup(8, GPIO.OUT, initial=GPIO.LOW)
GPIO.setup(10, GPIO.OUT, initial=GPIO.LOW)
GPIO.setup(12, GPIO.OUT, initial=GPIO.LOW)

while True:
    os.system("bluetoothctl discoverable on")
    server_sock = BluetoothSocket(RFCOMM)
    server_sock.bind(("", PORT_ANY))
    server_sock.listen(1)
    port = server_sock.getsockname()[1]
    uuid = "94f39d29-7d6d-437d-973b-fba39e49d4ee"
    advertise_service(server_sock, "SampleServer",
                      service_id=uuid,
                      service_classes=[uuid, SERIAL_PORT_CLASS],
                      profiles=[SERIAL_PORT_PROFILE],
                      #                   protocols = [ OBEX_UUID ]
                      )
    print("Waiting for connection on RFCOMM channel %d" % port)
    client_sock, client_info = server_sock.accept()
    print("Accepted connection from ", client_info)
    try:
        while True:
            data = client_sock.recv(1024)
            # if len(data) == 0: break
            if(data == b'a'):
                print("fanta")
                GPIO.output(8, GPIO.HIGH)
                sleep(2)
                GPIO.output(8, GPIO.LOW)
            if(data == b'b'):
                print("cola")
                GPIO.output(10, GPIO.HIGH)
                sleep(2)
                GPIO.output(10, GPIO.LOW)
            if (data == b'c'):
                print("sprite")
                GPIO.output(12, GPIO.HIGH)
                sleep(2)
                GPIO.output(12, GPIO.LOW)
    except IOError:
        pass
        print("disconnected")

client_sock.close()
server_sock.close()
print("all done")
