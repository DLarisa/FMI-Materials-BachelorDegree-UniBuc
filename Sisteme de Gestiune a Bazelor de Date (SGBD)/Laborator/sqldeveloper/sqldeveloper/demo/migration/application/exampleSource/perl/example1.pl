#!/usr/local/bin/perl

    use Sybase::CTlib;

    ct_callback(CS_CLIENTMSG_CB, \&msg_cb);
    ct_callback(CS_SERVERMSG_CB, "srv_cb");
    $uid = 'mpeppler'; $pwd = 'my-secret-password'; $srv = 'TROLL';

    $X = Sybase::CTlib->ct_connect($uid, $pwd, $srv);

    $X->ct_execute("select * from sysusers");

    while(($rc = $X->ct_results($restype)) == CS_SUCCEED) {
        next if($restype == CS_CMD_DONE || $restype == CS_CMD_FAIL ||
                $restype == CS_CMD_SUCCEED);
        if(@names = $X->ct_col_names()) {
             print "@names\n";
        }
        if(@types = $X->ct_col_types()) {
             print "@types\n";
        }
        while(@dat = $X->ct_fetch) {
             print "@dat\n";
        }
    }

    print "End of Result Set\n" if($rc == CS_END_RESULTS);
    print "Error!\n" if($rc == CS_FAIL);

    sub msg_cb {
        my($layer, $origin, $severity, $number, $msg, $osmsg, $dbh) = @_;

        printf STDERR "\nOpen Client Message: (In msg_cb)\n";
        printf STDERR "Message number: LAYER = (%ld) ORIGIN = (%ld) ",
               $layer, $origin;
        printf STDERR "SEVERITY = (%ld) NUMBER = (%ld)\n",
               $severity, $number;
        printf STDERR "Message String: %s\n", $msg;
        if (defined($osmsg)) {
            printf STDERR "Operating System Error: %s\n", $osmsg;
        }
        CS_SUCCEED;
    }

    sub srv_cb {
        my($dbh, $number, $severity, $state, $line, $server,
           $proc, $msg) = @_;

    # If $dbh is defined, then you can set or check attributes
    # in the callback, which can be tested in the main body
    # of the code.

        printf STDERR "\nServer message: (In srv_cb)\n";
        printf STDERR "Message number: %ld, Severity %ld, ",
               $number, $severity;
        printf STDERR "State %ld, Line %ld\n", $state, $line;

        if (defined($server)) {
            printf STDERR "Server '%s'\n", $server;
        }

        if (defined($proc)) {
            printf STDERR " Procedure '%s'\n", $proc;
        }

        printf STDERR "Message String: %s\n", $msg;  CS_SUCCEED;
    }
