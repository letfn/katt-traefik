package boot

import (
	"github.com/defn/boot"
	"tool/exec"
)

command: vendor: exec.Run & {
	cmd: "hof mod vendor"
}

command: gen: boot.#Command & {
	"repo": repo
}
