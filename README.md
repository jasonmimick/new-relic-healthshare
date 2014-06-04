new-relic-healthshare
---------------------

A set of components for HealthShare&copy; which enable
reporting of system metrics up into the New Relic cloud
based application monitoring platform.

Getting Started
---------------

*Clone this repository.
*Load the src/ files into your HealthShare instance
*Choose a unique site or instance identifier (see below link)
*Make note of your API key
*Open an existing HealthShare production, add the NewRelic.Operation operation, name it and configure your API key and you're done.

Availble Meterics
--------------------

The NewRelic.Operation is configurable to send metrics based on different components of the system.
These metrics fall into the following categories:

*System - Reports low level Caché metrics into New Relic.
*Alerts - Reports Ensmeble Alerts into New Relic.
*MessageTraffic - Sends metrics on message traffic loads and errors to New Relic.

Each category maps to a component within a Plug In in the New Relic architecture.
Your unique site/instance idetifier is identifies one collection of components in the
New Relic user interface. You should select something unique. 

Defined Metrics

For MessageTraffic you'll see the following metrics

MessageTraffic/<PRODUCTION>/<COMPONENT>/<MESSAGE_COUNT>
MessageTraffic/<PRODUCTION>/<COMPONENT>/<MESSAGE_ERROR>

