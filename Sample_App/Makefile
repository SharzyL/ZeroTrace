
.PHONY: all clean

all: Sample_App LS_Client HSORAM_Client Test_Correctness

App_Cpp_Flags := -O2 -Wno-deprecated-declarations -Wno-cpp

Sample_App : Sample_App.cpp
	g++ $(App_Link_Flags) $(App_Cpp_Flags) Sample_App.cpp utils.cpp -L=$(CURDIR) -lZT -lcrypto -Wl,--rpath=$(CURDIR) -o sampleapp

LS_Client : LS_Client.cpp utils.cpp
	g++ $(App_Link_Flags) $(App_Cpp_Flags) LS_Client.cpp utils.cpp -L=$(CURDIR) -lZT -lcrypto -Wl,--rpath=$(CURDIR) -o lsclient

HSORAM_Client : HSORAM_Client.cpp utils.cpp
	g++ $(App_Link_Flags) $(App_Cpp_Flags) HSORAM_Client.cpp utils.cpp -L=$(CURDIR) -lZT -lcrypto -Wl,--rpath=$(CURDIR) -o hsoramclient

Test_Correctness : Test_Correctness.cpp utils.cpp
	g++ $(App_Link_Flags) $(App_Cpp_Flags) Test_Correctness.cpp utils.cpp -L=$(CURDIR) -lZT -lcrypto -Wl,--rpath=$(CURDIR) -o testcorrectness
