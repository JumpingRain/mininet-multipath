targets=client server sim-client sim-server
bins=$(patsubst %,bin/%,$(targets))

default: force sync

all : $(bins)

clean :
	rm -f $(bins)

force: clean all

sync:
	rsync -avz --delete ./ xia:~/result/mininet/
	ssh xia "rsync -avz --delete ~/result/mininet/ mininet:~/sync-saecf/"
	# rsync -avz --delete ./ mininet-vm:~/sync/
	# rsync -avz --delete ./ mpquic.aliyun:~/sync-saecf/
	# rsync -avz --delete ./ xia.client:~/sync-saecf/
	

bin/% : src/%
	GOOS=linux GOARCH=amd64 go build -o $@ ./$<

.PHONY : default clean force all sync
