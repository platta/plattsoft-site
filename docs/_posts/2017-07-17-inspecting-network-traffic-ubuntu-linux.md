---
title: Inspecting Network Traffic on Ubuntu Linux
date: '2017-07-17'
author: Adam

layout: post

permalink: /2017/07/17/inspecting-network-traffic-ubuntu-linux/

excerpt: |
  Inspecting network traffic is a pain. Here are a collection of (built-in)
  tools and techniques for seeing what's going on under the hood in Ubuntu
  Linux.

categories:
  - Technology
---
In the course of setting up my own OpenStack cloud, I found myself working up
and down through multiple layers of network virtualization. Needless to say, I
ran into plenty of network issues. To solve them, I researched, gathering small
bits of knowledge from many different websites ([Stack
Overflow](https://stackoverflow.com), I'm looking at you), forums, and IRC
channels. Once my cloud was up and running I lost track of a lot of this
information. But, recently, I encountered a new issue and found myself digging
through my old bookmarks. That's why I've decided to write up a consolidated
record of the knowledge and tools I've gathered for inspecting network traffic
and answering that age old question: "Why can't I ping that server?"

A lot of this applies for many Linux and Unix environments, but the specific
commands I'm providing for reference are intended for Ubuntu Linux (tested on
12.04 and 16.04).

## Basic tools

Let's start with the basics. The commands many folks have known for ages. Just
in case there's one you're less familiar with, give these a skim anyway.

### ifconfig

Good old `ifconfig`. I've been using this one for years to find out what my IP
address is. It's good for a couple other things as well.

``` bash
# Display information on all adapters.
ifconfig

# Display information on a specific adapter.
ifconfig eth0

# Bring an adapter up.
sudo ifconfig eth0 up

# Bring an adapter down.
sudo ifconfig eth0 down
```

### ip

Interestingly, `ifconfig` is considered outdated by many. I don't doubt that the
`ip` command which supersedes it is better and more powerful, but I still think
it will take a very long time for `ifconfig` to die out completely. Regardless,
it's good to be familiar with how it's used.

``` bash
# Display address information for all adapters.
ip addr show

# Display address information for a specific adapter.
ip addr show eth0

# Bring an adapter up.
sudo ip link set eth0 up

# Bring an adapter down.
sudo ip link set eth0 down
```

### route

The `route` command lets you see the system's routing table. This is how it
determines which interface to send traffic out on depending on the destination
address.

``` bash
# Display the system routing table
route
```

### nslookup

My troubleshooting generally has to do with being unable to contact a server,
but at times DNS resolution is the issue. In these cases, `nslookup` is great
for checking whether or not you're able to resolve DNS queries.

``` bash
# Look up the IP address of the given name using the default DNS server.
nslookup google.com

# Look up the IP address of the given name using the specified DNS server.
nslookup google.com 8.8.8.8
```

### netstat

I generally use `netstat` on the server side of the connection when I need to
make sure that my server is actually running and listening on the correct port.
You can also use this command to show packet statistics on various protocols.
This can be a huge help in identifying lower level networking issues.

``` bash
# Display all listening TCP ports.
# -p shows process information for each listener (requires sudo).
# -l shows only listening sockets.
# -n shows numeric IP addresses and port numbers.
# -t shows TCP listeners. You can use -u to see UDP listeners instead.
sudo netstat -plnt

# Displays statistics for various protocols.
netstat -s
```

### watch

The `watch` command has nothing to do with networking, but I often use it to
monitor the output of the above commands. What it does is periodically re-run a
command and display its output on a fresh screen. There is also a parameter to
have `watch` highlight any changes in the command's output.

``` bash
# Watch a command
watch &lt;command&gt;

# Specify the refresh interval in seconds (default is 2 seconds)
watch -n 1 &lt;command&gt;

# Highlight changes
watch -d &lt;command&gt;
```

---

These are the basic commands I use to check on the status and general
configuration of a machine that I am troubleshooting. It can also be handy to
reference these files:

``` bash
# Local hostname resolution.
/etc/hosts

# Configured DNS servers.
/etc/resolv.conf
```

Step one should always be to use these tools to ensure you have everything
configured correctly. If you see that your adapter has an APIPA address (one of
those weird looking 169.254.X.X addresses) you'll know pretty quickly why
nothing is working - you haven't gotten a valid IP address from a DHCP server.
If you're sure everything is configured correctly but you're still having
issues. It's time to move on to the next tool.

## tcpdump

The above tools are really for inspecting your configuration, not inspecting
network traffic. If you're pretty sure your network settings are correct, it's
time to watch some of the actual traffic going across the wire. To do that, I
use `tcpdump`. Since `tcpdump` puts the network interface it's monitoring into
promiscuous mode, you'll always need to use `sudo` when executing it. Beyond
that, there is one parameter you'll always want to pass, the `-i` parameter, to
tell `tcpdump` which network interface to watch. You can pass `-i any` to watch
all interfaces, but generally you're going to be focusing on a specific one.

The absolute simplest test you can do is to use tcpdump on both your sending and
receiving machines to watch ICMP traffic as you have them try to ping each
other.

``` bash
# Watch all ICMP traffic on the specified interface.
# -n displays IP addresses instead of resolving host names.
# -i specifies the interface to listen on.
# -p specifies the protocol to filter for.
sudo tcpdump -ni eth0 -p icmp
```

If you're debugging a more complex issue than basic connectivity, you're going
to need a different filter. However, even the broadest filter should still
exclude the SSH traffic that is going back and forth between your local machine
and the machine you're debugging. The simplest way to do that is to ignore all
traffic on port 22.

``` bash
# Display all traffic except for SSH.
sudo tcpdump -ni eth0 not port 22
```

## iptables

Using `tcpdump` should give you a lot of insight when inspecting network
traffic. It might still be necessary to dig deeper, though. Digging deeper for
me means inspecting the `iptables` firewall and monitoring the progress of
individual packets through its complex system of tables and chains. In fact,
troubleshooting `iptables` is so complicated and annoying that I'm going to
write a separate post about it. I will, however, leave you with a short list of
issues I've seen via `tcpdump` that I needed an understanding of `iptables` to
understand and resolve:

- Traffic being sent out a public interface with an improperly NATed source IP.
- Outbound traffic that never receives a response from the server.
- Inbound traffic that passes the public interface but never makes it to the
  correct private interface.
- Communication that works initially but suddenly inbound packets stop getting
  received.

The decisions about which packets to accept, where to route them, and whether or
not to NAT the source or destination addresses all happen in `iptables`, and
when I finish my follow-up post, I will tell you all I've learned about it
(hint: it's way more than I ever wanted to know).

---

What other techniques do you use for inspecting network traffic in your virtual
environments? Let me know in the comments, and help this post be the oasis of
information that saves many some poor souls from pulling all their hair out!
