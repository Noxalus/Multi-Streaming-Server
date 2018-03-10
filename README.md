# Multi Streaming Server
A Nginx server with RTMP module to send video streaming to multiple services.

If you have an optical fiber connection, you might want to send your live streams to multiple services to reach a wider audience. 

If you use Open Broadcast Software, I know it's possible to launch multiple instances, but it has a large CPU cost.

With this project, you can have only one stream to send and the Nginx RTMP server will dispatch this stream to every streaming services that you want. The only brake is your upload speed.

Please note that you also can encode your stream on the fly. If you want to stream to Youtube Gaming in 1080p at 60 FPS and on Twitch in 720p at 30 FPS, it's possible changing the Nginx configuration file.

## Prerequisites

To work on Windows, this project needs to run a Unix virtual machine (*exec* command doesn't work on Windows) using [VirtualBox](https://www.virtualbox.org/wiki/Downloads). This VM is automatically setup using [Vagrant](https://www.vagrantup.com/).

You also need a software to stream to the Nginx server. I personally used [Open Broadcast Software](https://obsproject.com/).

## Usage

Rename the file **nginx.template.conf** (located into *nginx/conf/*) to **nginx.conf** and change its content with your specific data. For instance, you need to change **{{ youtube_key }}** by your Youtube stream key.

Then, launch this command at the root folder of this project (where there is the *Vagrant* file):

```shell
vagrant up
```

If you see the message "*Nginx is ready to use*", you can start to stream. With OBS, change the RTMP URL to **rtmp://192.168.42.42:1935/live**, you don't need to enter a stream key.

To check that the stream is properly received and sent to each services, you can browse to http://192.168.42.42:8080/stat.

## FAQ

- [How to install on a dedicated server](https://github.com/Noxalus/Multi-Streaming-Server/wiki/How-to-install-on-a-dedicated-server)
- [How to display all services' chat messages in the same place](https://github.com/Noxalus/Multi-Streaming-Server/wiki/How-to-display-all-services'-chat-messages-in-the-same-place)
- [How to handle new services](https://github.com/Noxalus/Multi-Streaming-Server/wiki/How-to-handle-new-services)