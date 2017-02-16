Docker Swarm-Mode Network Benchmark Tool
=======================================

This tool measures the network quality of service across all nodes in a Swarm by capturing the following metrics over an extended time period:
- UDP and TCP packet loss rate and round-trip delay time for all links
- Percentage of Docker Engine Gossip traffic per link
- Network Partition & Merge transient times

Individual measurements will be stored on a local volume on each node. When the benchmark operation is stopped,
these measurements will be gathered on the tool runner container and processed into final results

Usage (engine 1.13 or higher)
=============================

The tool supports the following operations:

* start/continue benchmark:
	```
		docker run --rm -v /var/run/docker.sock:/var/run/docker.sock alexmavr/swarm-nbt start
	```

* stop benchmark:
	```
		docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /path/to/results/dir:/output alexmavr/swarm-nbt stop  
	```

Viewing Metrics 
===============

The benchmark tool starts a prometheus server on port 9090 of a single node in
the cluster. The metrics can be viewed either directly on prometheus or using a
graphana dashboard.

Engine 1.12 Compatibility Mode with Docker Swarm (not Swarm-Mode)
====================================================

This tool can be ran when the local docker client is pointing to a Docker Swarm
cluster rather than a single engine, such as Docker Universal Control Plane, 
with the following invocation:

* Start benchmark: This command will output a series of docker operations to be
  ran against the same shell
```
docker info | docker run -i -v inventory:/inventory --rm alexmavr/swarm-nbt start --compat
```

* Stop benchmark: 
```
docker info | docker run -i --rm alexmavr/swarm-nbt stop --compat
```



