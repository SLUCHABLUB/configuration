ESH ?= esh
MODES := dark light

ALL_TEMPLATES := $(shell find . -name '*.esh' -not -path './.git/*')

# A mode-template's basename (with .esh stripped) is either "MODE" or starts with "MODE.".
# Those are split off; everything else is built once via the generic pattern rule below.
is_mode = $(filter MODE MODE.%,$(basename $(notdir $1)))
MODE_TEMPLATES   := $(foreach t,$(ALL_TEMPLATES),$(if $(call is_mode,$t),$t))
SINGLE_TEMPLATES := $(filter-out $(MODE_TEMPLATES),$(ALL_TEMPLATES))

SINGLE_OUTPUTS := $(SINGLE_TEMPLATES:.esh=)

# For each mode template, the output filename is the template's basename (sans .esh)
# with the leading "MODE" replaced by the actual mode name.
#   MODE.ini.esh + dark -> dark.ini
#   MODE.esh     + dark -> dark
mode_output = $(dir $1)$(patsubst MODE%,$2%,$(basename $(notdir $1)))

MODE_OUTPUTS := $(foreach m,$(MODES),$(foreach t,$(MODE_TEMPLATES),$(call mode_output,$t,$m)))

.PHONY: all clean
all: $(SINGLE_OUTPUTS) $(MODE_OUTPUTS)

%: %.esh
	$(ESH) -o $@ -- $<

define mode_rule
$(call mode_output,$1,$2): $1
	TILIA_MODE=$2 $$(ESH) -o $$@ -- $$<
endef
$(foreach m,$(MODES),$(foreach t,$(MODE_TEMPLATES),$(eval $(call mode_rule,$t,$m))))

clean:
	rm -f $(SINGLE_OUTPUTS) $(MODE_OUTPUTS)
