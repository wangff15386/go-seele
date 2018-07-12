package cmd

import "testing"

func Test_start(t *testing.T) {
	c := "C:/Users/dell-20/go/src/github.com/seeleteam/go-seele/cmd/node/config/node1.json"
	s := "start"
	accountsConfig = "C:/Users/dell-20/go/src/github.com/seeleteam/go-seele/cmd/node/config/accounts.json"
	miner = &s
	seeleNodeConfigFile = &c
	start()
}
