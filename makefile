ESH ?= esh

TEMPLATES := $(shell find . -name '*.esh' -not -path './.git/*')
OUTPUTS := $(TEMPLATES:.esh=)

.PHONY: all clean
all: $(OUTPUTS)

%: %.esh
	$(ESH) -o $@ -- $<

clean:
	rm -f $(OUTPUTS)
