Gremlin Server
==============

Apache TinkerPop™ is a graph computing framework for both graph databases 
(OLTP) and graph analytic systems (OLAP).

Learn more:

* [Gremlin Server official documentation][SRVR]
* [Apache TinkerPop homepage][HOME]


Getting Started
---------------

Creating the image:

    docker build \
      --rm \
      --tag gremlin-server:3.3.3 \
      .

Running the image:

    docker run \
      --detach \
      --rm \
      --name gremlin-server \
      --publish 8182:8182 \
      gremlin-server:3.3.3



[HOME]: http://tinkerpop.apache.org/
[SRVR]: http://tinkerpop.apache.org/docs/current/reference/#gremlin-server
