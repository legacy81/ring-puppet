# add things that should be checked here                                        
class nagios_services {                                                 

    # this will create a nagios_service for both IPv4 pings and IPv6 pings
    # towards the FQDN of the node that's including this class
    # names of the services: check_ping and check_ping6
    nagios::service::ping { $name: }                      

    # this will create a nagios_service for both IPv4 ssh check and IPv6 ssh check
    # towards the FQDN of the node that's including this class
    # names of the services: check_ssh4 and check_ssh6
    nagios::service::ssh { $name: } 

    # these virtual exported resources will create a dependeny between
    # the IPv4 ping check and the IPv4 SSH check
    # thus not alerting for ssh if ping fails first
    @@nagios_servicedependency { "${fqdn}_dep_ssh_4": 
        service_description             => "check_ping",
        dependent_service_description   => "check_ssh4",
        host_name                       => "${fqdn}",
        dependent_host_name             => "${fqdn}",
    }

    # these virtual exported resources will create a dependeny between
    # the IPv6 ping check and the IPv6 SSH check
    # thus not alerting for ssh if ping fails first
    @@nagios_servicedependency { "${fqdn}_dep_ssh_6":
        service_description             => "check_ping6",
        dependent_service_description   => "check_ssh6",
        host_name                       => "${fqdn}",
        dependent_host_name             => "${fqdn}",
    }
}
