FROM mongo:3.5
RUN apt-get update
RUN apt-get install -y  munin munin-node munin-plugins-extra
COPY munin-node.conf /etc/munin/munin-node.conf
RUN rm /etc/munin/plugins/df /etc/munin/plugins/df_inode /etc/munin/plugins/diskstats /etc/munin/plugins/exim_mailqueue /etc/munin/plugins/fw_packets /etc/munin/plugins/interrupts /etc/munin/plugins/if* /etc/munin/plugins/irqstats /etc/munin/plugins/munin_stats  /etc/munin/plugins/swap /etc/munin/plugins/users /etc/munin/plugins/vmstat
RUN apt-get install -y python-pip
RUN pip install simplejson
COPY munin/mongo_btree /usr/share/munin/plugins/mongo_btree
COPY munin/mongo_conn /usr/share/munin/plugins/mongo_conn
COPY munin/mongo_lock /usr/share/munin/plugins/mongo_lock
COPY munin/mongo_mem /usr/share/munin/plugins/mongo_mem
COPY munin/mongo_ops /usr/share/munin/plugins/mongo_ops
RUN chmod +x /usr/share/munin/plugins/mongo*
RUN ln -s /usr/share/munin/plugins/mongo_btree /etc/munin/plugins/mongo_btree
RUN ln -s /usr/share/munin/plugins/mongo_conn /etc/munin/plugins/mongo_conn
RUN ln -s /usr/share/munin/plugins/mongo_lock /etc/munin/plugins/mongo_lock
RUN ln -s /usr/share/munin/plugins/mongo_mem /etc/munin/plugins/mongo_mem
RUN ln -s /usr/share/munin/plugins/mongo_ops /etc/munin/plugins/mongo_ops
RUN apt-get purge git curl -y && \
    rm -rf /var/lib/apt/lists/*