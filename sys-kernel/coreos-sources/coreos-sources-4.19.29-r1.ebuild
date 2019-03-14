# Copyright 2014 CoreOS, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
ETYPE="sources"

# -rc releases should be versioned L.M_rcN
# Final releases should be versioned L.M.N, even for N == 0

# Only needed for RCs
K_BASE_VER="4.19"

inherit kernel-2
detect_version

DESCRIPTION="Full sources for the CoreOS Linux kernel"
HOMEPAGE="http://www.kernel.org"
if [[ "${PV%%_rc*}" != "${PV}" ]]; then
	SRC_URI="https://git.kernel.org/torvalds/p/v${KV%-coreos}/v${OKV} -> patch-${KV%-coreos}.patch ${KERNEL_BASE_URI}/linux-${OKV}.tar.xz"
	PATCH_DIR="${FILESDIR}/${KV_MAJOR}.${KV_PATCH}"
else
	SRC_URI="${KERNEL_URI}"
	PATCH_DIR="${FILESDIR}/${KV_MAJOR}.${KV_MINOR}"
fi

KEYWORDS="amd64"
IUSE=""
RDEPEND+="
	sys-devel/bison
	sys-devel/flex
"

# XXX: Note we must prefix the patch filenames with "z" to ensure they are
# applied _after_ a potential patch-${KV}.patch file, present when building a
# patchlevel revision.  We mustn't apply our patches first, it fails when the
# local patches overlap with the upstream patch.
UNIPATCH_LIST="
	${PATCH_DIR}/z0001-kbuild-derive-relative-path-for-KBUILD_SRC-from-CURD.patch \
	${PATCH_DIR}/z0002-tools-objtool-Makefile-Don-t-fail-on-fallthrough-wit.patch \
	${PATCH_DIR}/z0003-net-netfilter-add-nf_conntrack_ipv4-compat-module-fo.patch \
	${PATCH_DIR}/z0004-Revert-loop-drop-caches-if-offset-or-block_size-are-.patch \
	${PATCH_DIR}/z0005-Revert-loop-Fix-double-mutex_unlock-loop_ctl_mutex-i.patch \
	${PATCH_DIR}/z0006-Revert-loop-Get-rid-of-nested-acquisition-of-loop_ct.patch \
	${PATCH_DIR}/z0007-Revert-loop-Avoid-circular-locking-dependency-betwee.patch \
	${PATCH_DIR}/z0008-Revert-loop-Fix-deadlock-when-calling-blkdev_reread_.patch \
	${PATCH_DIR}/z0009-Revert-loop-Move-loop_reread_partitions-out-of-loop_.patch \
	${PATCH_DIR}/z0010-Revert-loop-Move-special-partition-reread-handling-i.patch \
	${PATCH_DIR}/z0011-Revert-loop-Push-loop_ctl_mutex-down-to-loop_change_.patch \
	${PATCH_DIR}/z0012-Revert-loop-Push-loop_ctl_mutex-down-to-loop_set_fd.patch \
	${PATCH_DIR}/z0013-Revert-loop-Push-loop_ctl_mutex-down-to-loop_set_sta.patch \
	${PATCH_DIR}/z0014-Revert-loop-Push-loop_ctl_mutex-down-to-loop_get_sta.patch \
	${PATCH_DIR}/z0015-Revert-loop-Push-loop_ctl_mutex-down-into-loop_clr_f.patch \
	${PATCH_DIR}/z0016-Revert-loop-Split-setting-of-lo_state-from-loop_clr_.patch \
	${PATCH_DIR}/z0017-Revert-loop-Push-lo_ctl_mutex-down-into-individual-i.patch \
	${PATCH_DIR}/z0018-Revert-loop-Get-rid-of-loop_index_mutex.patch \
	${PATCH_DIR}/z0019-Revert-loop-Fold-__loop_release-into-loop_release.patch \
"
